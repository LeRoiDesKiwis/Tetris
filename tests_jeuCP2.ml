open CPutil;;
open JeuCP2;;




let test_draw_absolute_pt_functional(status : t_test_status) : unit =
  let test_step : t_test_step = test_start(status, "draw_absolute_pt") in
  let test_result : unit t_test_result = test_exec(test_step, draw_absolute_pt, ()) in
  (
    if test_is_success(test_result)
    then
      (
        
      )
    else test_error(test_step);
    test_end(test_step)
  )
;;





let test_run() : unit = 
  let alltests : t_test_status = create_test_status() in
  (
    clear_graph();
    
    (* test de draw_absolute_pt*)
    test_card_color_of_int_a(alltests) ;
    test_card_color_of_int_b(alltests) ;
    test_card_color_of_int_fail_c(alltests) ;
    test_card_color_of_int_fail_d(alltests) ;

    (* test de card_rank_of_int_52 *)
    test_card_rank_of_int_52_a(alltests) ;
    test_card_rank_of_int_52_b(alltests) ;
    test_card_rank_of_int_52_fail_c(alltests) ;
    test_card_rank_of_int_52_fail_d(alltests) ;

    (* test de card_of_int *)
    test_card_of_int_52_fail_c(alltests) ;
    test_card_of_int_52_fail_d(alltests) ;

    (* test de card_color_of_int_52 *)
    test_card_of_color_of_int_52_a1(alltests) ;
    test_card_of_color_of_int_52_b1(alltests) ;

    (* test de distribute_structural*)
    test_distribute_structural(alltests) ;
    test_distribute_4cards_functional(alltests) ;
    
    (* Print test status at the end *)
    print_test_report(alltests)
    )
;;
