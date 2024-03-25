//SV Topics : Mailbox
//Problem statement : to use mailbox to communicate between parallel threads
//======================================

module test;
  mailbox arun;		//declaring mailbox
  
  static task square();	
    int a;
    arun.get(a);		//wait till mailbox recieves a value
    $display($time, ", square of %0d is %0d", a, a**2);  //printing square and time
    
  endtask
  
  static task cube(int b);
    #5;
    $display($time, ", cube of %0d is %0d", b, b**3);
    arun.put(b);					//put the value in mailbox
  endtask
  
  initial begin
    arun = new(1);	//instantiating a mailbox with size 1
    fork
      cube(7);		//2 parallel threads
      square;
    join
  end
endmodule
