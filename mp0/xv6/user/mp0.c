#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

void traverse_dir(char *path, char *key, int *dir_count, int *file_count) {
    char buf[512];
    char *p;
    int fd;
    struct dirent de;
    struct stat st;

    if((fd = open(path, 0)) < 0) {
        fprintf(2, "%s [error opening dir]\n", path);
        return;
    }
    
    // copy path to buffer
    strcpy(buf, path);
    p = buf + strlen(buf);
    *p++ = '/';

    while(read(fd, &de, sizeof(de)) == sizeof(de)) {
        if(de.inum == 0) {
	        continue;
	    }
        
        // move the current file name to buffer
        memmove(p, de.name, DIRSIZ);
        p[DIRSIZ] = 0;
        
        if(strcmp(".", p) == 0 || strcmp("..", p) == 0) {
            continue;
        }
        
        if(stat(buf, &st) < 0) {
            printf("%s [error opening dir]\n", buf);
            continue;
        }
        
        // calculate how many key matches in buffer
        int matches = 0;
        for(int i = 0; i < strlen(buf); i++) {
            if(buf[i] == *key) {
                matches++;
            }
        }
        printf("%s %d\n", buf, matches);
        
        if(st.type == T_DIR) {
            // a directory, so traverse recursively
            (*dir_count)++;
            traverse_dir(buf, key, dir_count, file_count);
        }
        else if(st.type == T_FILE) {
            // a file
            (*file_count)++;
        }
    }
    
    // clos the file descripter
    close(fd);
}


int main(int argc, char* argv[]) {
    if(argc != 3) {
        exit(0);
    }
    
    int pipe_fd[2];
    pipe(pipe_fd);
    int pid = fork();
     
    if(pid == 0) {
        // child process
	    int dir_count = 0;
        int file_count = 0;
       
        // check if we can open the root and if it's a diectory	
	    int fd;
        struct stat st;
	    if((fd = open(argv[1], 0)) < 0) {
            fprintf(2, "%s [error opening dir]\n", argv[1]);
            exit(0);
        }
	    if(stat(argv[1], &st) < 0) {
            printf("%s [error opening dir]\n", argv[1]);
            close(fd);
	        exit(0);
        }
	    if(st.type == T_FILE) {
            printf("%s [error opening dir]\n", argv[1]);
	        close(fd);
	        exit(0);
	    }
        
        // calculate how many key matches in the root directory
        int matches = 0;
        char* ptr = argv[1];
        while(*ptr != '\0') {
            if(*ptr == *argv[2]) {
                matches++;
            }
            ptr++;
        }
        printf("%s %d\n", argv[1], matches);
        
        traverse_dir(argv[1], argv[2], &dir_count, &file_count);
            
        // no need to use the read end of pipe so close it
        close(pipe_fd[0]);
        
        // write the counts to the pipe
        write(pipe_fd[1], &dir_count, sizeof(int));
        write(pipe_fd[1], &file_count, sizeof(int));
        
        // close the write end of the pipe
        close(pipe_fd[1]);
        
        exit(0);
    } 
    else {
        // parent process
        int file_count = 0;
        int dir_count = 0;
        
	    // no need to ues the write end of pipe so close it
        close(pipe_fd[1]);
        
        // read the counts from the pipe
	    read(pipe_fd[0], &dir_count, sizeof(int));
	    read(pipe_fd[0], &file_count, sizeof(int));
     	
    	// close the read end of the pipe
        close(pipe_fd[0]);
   	
        printf("\n%d directories, %d files\n", dir_count, file_count);
    }

    exit(0);
}

