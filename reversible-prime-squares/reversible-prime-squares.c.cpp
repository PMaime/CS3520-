#include <stdio.h>
#include<stdlib.h>
#include <stdbool.h>

int reverse(int num)
{
	int r;                     
	int reverse=0;
	while(num!=0)
	{
		r=num%10;
		reverse= (reverse*10)+r;
		num=num/10;
	}
	return reverse;
	
}

bool primeCheck(int num)
{
	bool isPrime=true;
	
	if(num==0)
	{
		isPrime = false;
	}
	if(num==1)
	{
		isPrime = false;
	}
	
	for(int i=2; i <= num/2; i++)
	{
		if(num%i == 0)
		{
			isPrime = false;
			break;
		}
		
	}
	return isPrime;
}

bool notPalindrome(int num)
{
	bool isPalindrome = true;
	if(reverse(num) == num)
	{
		isPalindrome = false;
	}
	return isPalindrome;
}

bool isPerfect(int num)
{
    for(int i=1; i*i <= num; i++ )
    {
        if((num % i == 0) && (num / i == i))
        {
            return true;
            printf("%d",num);
        }
    }

    return false;
}
int squrt(int x)
{
	if(x==0)
	{
		return x;
	}
	if(x==1)
	{
		return x;
	}
	
	int i = 1;
	int result = 1;
	while (result<= x)
	{
		i++;
		result = i * i;
	}
	return i - 1;
}


int main()
{
	int j = 0;
	int x,s,l;
	
	printf("**************10 reversible prime squares**************\n\n");
	printf("Prime                  Square                  Reverse \n");

	for(int i=0; i>=0; i++)
	{
		
		int s = reverse(i);

        if(isPerfect(i) == true && isPerfect(s) == true)
        {
            x = squrt(i);
            l = squrt(s); 

            if(primeCheck(x) == 1 && primeCheck(l)==1)
            {
                if(notPalindrome(i))
                {
                	
                	printf("%d",x);
                    printf("%25d",i);
                    printf("%25d\n",s);
                    j++;
                    if(j == 10)
                    {
                    	break;
					}
                }

            }
        }
			
	}

	
	return 0;
}
