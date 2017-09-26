READ ME File for Distributed Operating Systems – Project 1
Date: September 18, 2017

Group Members:

1.	Kavin Desai, UF ID: 0895-9351, kdesai261@ufl.edu
2.	Vaishali Vijaykumar, UF ID: 4088-7699, vaishalivkumar25@ufl.edu

To get the IP we used the following function --> {:ok,z}=:inet.getif()
Assuming the OS on UF server is Linux, we are extracting the first values in the :inet.getif(). For other OS the program may not work as the IP address can
be in a different tuple.

Implementation Details:

1.	WORK UNIT
	The string generation method is random. We create a list for upper-case characters, lower-case characters, numbers and special characters each and shuffle it
	4 times. Then we take 5 random strings from the shuffled list and concatenate it with the given string "kdesai261;". It is also iterative as we concatenate the
	count value which increases every iteration.
		We decided to use an iterative approach combined with random approach for the following reasons:
		a) iterative approach ensures that there are no duplicates
		b) random string ensures that two processes may not reach at the same string value. 
		
	1000 processes are created for Bitcoin mining, any further increase in number of processes gives no performance improvement.


2.	The result of running our program for 4 zeroes
	./project1 4
	
	kdesai261;!u5g0oS*N32@ysnajUl57      0000314D0861B61887F6BE8E293D433B6571CD1F57ECA44481685F332C0D7FAC
	kdesai261;9M(zBCDQoT9OBF8Y)G661      0000A4B9AEFA8DA4FEE7C564B7E55F985C5433BD9C5221A4DEE76789E3C87926
	kdesai261;@ES&S6B@dVl0pkzoks@66      0000528FF617B14659ED37078D08DF8B0E1E8889228F3C861FE204B17632C312
	
	We were able to mine 84 coins with 4 leading zeroes in 10 minutes among which 6 coins had 5 leading zeroes and 1 with 6 leading zeroes
	
	kdesai261;kLh4Q8cDcs#bmLRkn6F4      000000C10E77D68F29713D5EC1BFA7AA6D2B5C7654C79F6C5BE5E1F40856F480
	
3.	The result of running our program for 5 zeroes
	./project1 5
	
	kdesai261;hd40G85K1rmDh!)Z!AC2190      00000154AF1B2A2363C4F7F75B6DF342174D4A397EC0C8BA03647F2E2E04D2AE
	kdesai261;hUsey^zA9SENDvS)KhU2204      000000F1999403A6251CB9D1F2956D536822163A9B92B109289AE6956E0AC
	kdesai261;CAZyCwLZr*Bba@kLltS2235      0000048C0C51FE99D817B4A4EE0B173011547C7BC95F35C41DE01E3F96DE76EC
	kdesai261;EsA0Dd$0I7xTdL2X(8f2372      00000F7BF89FAFB4A3539C000A3230E664697F74FB3005EDB87B5EF525BE82A4
	^C
	real	0m33.733s
	user	1m56.291s
	sys		0m2.498s
	
	(Total CPU time)/(Number of CPUs) would be same as elapsed real time if the work load is evenly distributed on each CPU and no wait is involved for I/O or other resources.
	Here, 
		Total CPU time = 1m56.291s + 0m2.498s = 1m58.789s = 118.789s
		Real Time = 33.733s
		The ratio of CPU time to real time = 3.52
	
	We were able to mine 16 coins with 5 leading zeroes in 10 minutes among which 2 coins had 6 leading zeroes.
	
4. 	The coin with the most zeroes we managed to find is 8.
	To increase the chances of getting 8 leading zeroes, we are using 32 random characters after the given string(kdesai261;) 
	./project1 8
	
	kdesai261;ZIgUx5/HpPCYgB3H4B/PwXQ/NAVjM0C8      0000000067561F4ABE9D82091B32020E0371D1FAE7B5429977E1DD68437B1B37
		
5. 	The largest number of working machines we were able to run our code with is 5 - 4 miners and 1 master.