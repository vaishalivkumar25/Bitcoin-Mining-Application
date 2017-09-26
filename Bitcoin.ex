defmodule Bitcoin do
    use GenServer

 def main(args) do

   
  
   x=hd(args)
   if(String.length(x)<6) do
        number=String.to_integer(x)
        {:ok,z}=:inet.getif()
        first=to_string(elem(elem(List.last(z),0),0))
        second=to_string(elem(elem(List.last(z),0),1))
        third=to_string(elem(elem(List.last(z),0),2))
        fourth=to_string(elem(elem(List.last(z),0),3))
        final_ip=first<>"."<>second<>"."<>third<>"."<>fourth

        server_n="one@"<>final_ip
        server_node=String.to_atom(server_n)
        
        
        Node.start server_node
        Node.set_cookie :choco

        Bitcoin.start_link
        Bitcoin.add_msg(number)
        process(1000,number,server_node)
        

    else
        {:ok,z}=:inet.getif()
        first=to_string(elem(elem(List.last(z),0),0))
        second=to_string(elem(elem(List.last(z),0),1))
        third=to_string(elem(elem(List.last(z),0),2))
        fourth=to_string(elem(elem(List.last(z),0),3))
        final_ip=first<>"."<>second<>"."<>third<>"."<>fourth

        client_n="two@"<>final_ip
        client_node=String.to_atom(client_n)

        Node.start client_node 
        Node.set_cookie :choco

        server_ip="one@"<>x
        server_ip_atom=String.to_atom(server_ip)
        IO.puts(server_ip_atom)
        Node.connect server_ip_atom
        IO.inspect Node.list
        state=GenServer.call({:project1, server_ip_atom}, :get_msgs)

        IO.inspect(state)
        s=hd(state)
        size=String.to_integer(s)
        process(200,size,server_ip_atom)
  

    end

    IO.gets ""


  end

 
  def process(n,zero,server_name) when n<=1 do
    spawn(Bitcoin, :print, [100000,0,zero,server_name])
  end

  def process(n,zero,server_name) do
    spawn(Bitcoin, :print, [100000,0,zero,server_name])
    process(n-1,zero,server_name)
  end


  def print(n,count,noz,server_name) when n <= 1 do
    gator_id = "kdesai261;"
  #  a=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
   # b=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
   # c=['0','1','2','3','4','5','6','7','8','9']
   # d=['!','@','#','$','%','^','&','*','(',')']
   # e=a++b++c++d
   # w=e |> Enum.shuffle
   # x=w |> Enum.shuffle
   # y=x |> Enum.shuffle
   # z=y |> Enum.shuffle
   # first_part=Enum.take_random(z,4)
   # second_part=Enum.take_random(z,4)
   # third_part=Enum.take_random(z,4)
   # fourth_part=Enum.take_random(z,4)
   # final_list=first_part ++ second_part ++ third_part ++ fourth_part
    random_str_one=:crypto.strong_rand_bytes(6) |>Base.encode64
    random_str_two=:crypto.strong_rand_bytes(6) |>Base.encode64
    input_str = gator_id<>random_str_one<>random_str_two

    hash_val=Base.encode16(:crypto.hash(:sha256, input_str))
    init=String.slice(hash_val,0..(noz-1))
    string_of_zero=String.duplicate("0",noz)
    h_val ="      "<> hash_val
    final_output=input_str<>h_val

    if(init==string_of_zero) do

      GenServer.cast({:project1,server_name},{:add_msg,final_output})

      count=count+1
    end
        IO.puts(count)
 end

  def print(n,count,noz,server_name) do
    gator_id = "kdesai261;"
    random_str_one=:crypto.strong_rand_bytes(6) |>Base.encode64
    random_str_two=:crypto.strong_rand_bytes(6) |>Base.encode64
    input_str = gator_id<>random_str_one<>random_str_two

    hash_val=Base.encode16(:crypto.hash(:sha256, input_str))
    x=noz-1
    init=String.slice(hash_val,0..x)
    string_of_zero=String.duplicate("0",noz)
    h_val ="      "<> hash_val
    final_output=input_str<>h_val

    if(init==string_of_zero) do
      count=count+1

    GenServer.cast({:project1,server_name},{:add_msg,final_output})

    end
    print(n-1,count,noz,server_name)
  end

  #client side

    def start_link do
    GenServer.start_link(__MODULE__,[], name: :project1)
    end

    def get_msgs do
        GenServer.call(:project1, :get_msgs)
    end

    def add_msg(msg) do

        GenServer.cast(:project1,{:add_msg, msg})

    end
    #server side

    def init(msgs) do
        {:ok, msgs}
    end

    def handle_call(:get_msgs, _from, msgs) do
        {:reply,msgs,msgs}
    end

    def handle_cast({:add_msg, msg},msgs) do

        if(is_integer(msg)) do

        {:noreply,[msg| msgs]}
        
        else
       IO.puts(msg) 
        {:noreply,msgs}
    end


   
              
    end

end