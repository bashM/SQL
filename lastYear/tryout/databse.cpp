#include <stdio.h>
#include <stdlib.h>
struct student{
char firstname[100];               
char lastname[100];
};

int main ()
{
    FILE * pFile;
    FILE * f;
    int count;
    int gpac;
    struct student student[20];
    int age[1];
    float s=0;
    float gpa=0;
                                                      
    printf("-------------------------");
    printf("STUDENT DTATBASE PROJECT");
    printf("-------------------------\n\n");
    FILE *in;
    char c;
    in = fopen("sdata.txt", "r");
    if(in != NULL)
    {
        while((c = fgetc(in)) != EOF) putchar(c);
        printf("Current Students in Database\n%[]\n",c);
        fclose(in);
    }
                                                                                            
    for ( count = 1; count <11; count++)
    { 
        pFile = fopen ("sdata.txt","a");//Student Database File//
        printf("please enter student No[%d] First name\n",count);
        scanf("%s",student[count].firstname);
        printf("please enter student No[%d] Last name\n",count);
        scanf("%s",student[count].lastname);
        printf("please enter The Age for %s %s\n\n",student[count].firstname, student[count].lastname);
        scanf("%d",&age[1]);
        for ( gpac = 1; gpac <6; gpac ++)
           {
                                                                                                                                         
                                                                                                                               printf("please enter Course Credit For Course No[%d/5] Grade for %s %s\n\n",gpac,student[count].firstname, student[count].lastname);
                                                                                                                                                   scanf("%f",&gpa);
                                                                                                                                                         s=gpa+s;
                                                                                                                                                               s=s/5;
                                                                                                                                                                    };
                                                                                                                                                                      printf("%s %s gpa value is %f.\n\n",student[count].firstname, student[count].lastname,s); 
                                                                                                                                                                         fprintf (pFile, "First Name [%s]\nLast  Name [%s]\nAge   [%d]\nGPA[%6.1f]\n------------------\n", student[count].firstname,student[count].lastname,age[1],s);
                                                                                                                                                                            age[1]=0;
                                                                                                                                                                               fclose (pFile);
                                                                                                                                                                                  
                                                                                                                                                                                     FILE *in;
                                                                                                                                                                                       char c;
                                                                                                                                                                                         in = fopen("sdata.txt", "r");
                                                                                                                                                                                           if(in != NULL)
                                                                                                                                                                                                {
                                                                                                                                                                                                      while((c = fgetc(in)) != EOF) putchar(c);
                                                                                                                                                                                                         printf("%[]\n",c);
                                                                                                                                                                                                            fclose(in);
                                                                                                                                                                                                              }
                                                                                                     }
                                                                                                      
                                                                                                      return 0;
                     }


