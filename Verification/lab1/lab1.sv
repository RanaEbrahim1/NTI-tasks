module lab1;
//array partion
int arr_1[] = '{9,7,4,6,2,8,6,5};
int even_array[$];
int odd_array[$];

initial begin
    even_array = arr_1.find(x) with (x%2 == 0);
    odd_array  = arr_1.find(x) with (x%2 == 1);

    $display("EVEN ARRAY = %p",even_array);
    $display("ODD ARRAY  = %p" ,odd_array);
    $display("//////////DONE//////////");
end

//MAX. consecutive number 
int arr_2[] = '{1,1,0,1,1,1,1,0,0,0,1};
int count;
int unique_num[$];
int consecutive_num;
int count_consective = 0;

initial begin

    int current_count = 1;

    consecutive_num = arr_2[0];
    count_consective = 1;

    foreach (arr_2[i]) begin

        if (i == 0)
            continue;
        if (arr_2[i] == arr_2[i-1]) begin
            current_count++;
        end
        else begin
            current_count = 1;
        end
        if (current_count > count_consective) begin
            count_consective = current_count;
            consecutive_num = arr_2[i];
        end
    end

    $display("The number %0d repeated consecutively --> %0d times",
             consecutive_num, count_consective);
    $display("//////////DONE//////////");         

end

/*initial begin

    unique_num = arr_2.unique();

    foreach (unique_num[i]) begin
        count = 0 ;

        foreach (arr_2[j]) begin
            if (unique_num[i] == arr_2[j]) begin
                count++ ;
            end
        end

        $display("The number %0d repeated --> %0d times", unique_num[i], count);

        if (count > count_consective) begin
            count_consective = count;
            consecutive_num  = unique_num[i];
        end                     
    end

    $display("Consective number : %0d , repeated --> %0d ", consecutive_num,  count_consective);
    $display("//////////DONE//////////");
end*/

// Frequency counter 
int arr_3[] = '{8,3,3,4,5,6,3,5,4,6,8,7,6,4,3,5,6};
int count_3;
int unique_3 [$];

initial begin
    unique_3 = arr_3.unique();
    foreach (unique_3[i]) begin
        count_3 = 0 ;

        foreach (arr_3[j]) begin
            if (unique_3[i] == arr_3[j]) begin
                count_3++ ;
            end
        end

        $display("The number %0d repeated --> %0d times", unique_3[i], count_3);
                
    end
    $display("//////////DONE//////////");
end

//Second MAX
int arr_4[] = '{45,34,67,89,78};
int count_4;
int max_1;
int max_2;

initial begin
    max_1 = arr_4[0];
    max_2 = arr_4[0];
    foreach (arr_4[i]) begin
        if (arr_4[i] > max_1) begin
            max_1 = arr_4[i];
        end
    end    
    foreach (arr_4[j]) begin
        if ((arr_4[j] > max_2) && (arr_4[j] < max_1)) begin
            max_2 = arr_4[j];
        end
    end 

    $display("Fisrt MAX : %0d", max_1);
    $display("Second MAX : %0d", max_2);   
    $display("//////////DONE//////////");      
end

endmodule