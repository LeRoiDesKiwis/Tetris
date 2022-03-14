open CPutil;;

(* -------------------------- *)
(* -------------------------- *)
(*    fonctions utilitaires   *)
(* -------------------------- *)
(* -------------------------- *)


let mywait(x : float) : unit =
  let y : float ref = ref (Sys.time()) in
  while (Sys.time() -. !y) < x
  do ()
  done
;;


(* --------------------------------- *)
(* --------------------------------- *)
(*   Types et fonctions graphique    *)
(* --------------------------------- *)
(* --------------------------------- *)

type t_point = {x : int ; y : int} ;;


(* ------------------------------------------------- *)
(* ------------------------------------------------- *)
(*    Types, formes, parametrage et initialisation   *)
(* ------------------------------------------------- *)
(* ------------------------------------------------- *)


(* Types *)

type 'a t_array = {len : int ; value : 'a array} ;;

type t_shape = {shape : t_point list ; x_len : int ; y_len : int ; 
                rot_rgt_base : t_point ; rot_rgt_shape : int ; 
                rot_lft_base : t_point ; rot_lft_shape : int} ;; 

type t_cur_shape = {base : t_point ref ; shape : int ref ; color : t_color ref} ;;


type t_param_time = {init : float ; extent : float ; ratio : float} ;;

type t_param_graphics = 
    {base : t_point ; dilat : int ; color_arr : t_color t_array} ;;

type t_param = 
  {time : t_param_time ; 
   mat_szx : int ; mat_szy : int ;
   graphics : t_param_graphics ; 
   shapes : t_shape t_array
} ;;

type t_play = {par : t_param ; cur_shape : t_cur_shape ; mat : t_color matrix} ;;


(* Initialisation de quelques formes et des parametres *)

(*
let init_sh011() : t_shape = 
  {shape = [{x = 0 ; y = 0} ; {x = 1 ; y = 0} ; {x = 2 ; y = 0} ; {x = 3 ; y = 0}] ; 
  x_len = 4 ; y_len = 1 ; 
  rot_rgt_base = {x = 1 ;  y = 1} ; rot_rgt_shape = 1 ; 
  rot_lft_base = {x = 2 ; y = 1} ; rot_lft_shape = 1} 
;;
let init_sh112() : t_shape = 
  {shape = [{x = 0 ; y = 0} ; {x = 0 ; y = -1} ; {x = 0 ; y = -2} ; {x = 0 ; y = -3}] ; 
  x_len = 1 ; y_len = 4 ; 
  rot_rgt_base = {x = -2 ;  y = -1} ; rot_rgt_shape = 0 ; 
  rot_lft_base = {x = -1 ; y = -1} ; rot_lft_shape = 0} 
;;
let init_sh211() : t_shape = 
  {shape = [{x = 0 ; y = 0} ; {x = 0 ; y = -1} ; {x = 1 ; y = 0} ; {x = 1 ; y = -1}] ; 
  x_len = 2 ; y_len = 2 ; 
  rot_rgt_base = {x = 0 ;  y = 0} ; rot_rgt_shape = 2 ; 
  rot_lft_base = {x = 0 ;  y = 0} ; rot_lft_shape = 2} 
;;

let init_shapes() : t_shape t_array = 
  {len = 3 ; value = [| init_sh011() ; init_sh112() ; init_sh211() |]} 
;;
let init_color() : t_color t_array = 
  {len = 7 ; value = [|blue ; red ; green ; yellow ; cyan ; magenta ; grey|]} ;;

let init_param() : t_param = 
    {
    time = {init = 1.0 ; extent = 10.0 ; ratio = 0.8} ; 
    mat_szx = 15 ; mat_szy = 28 ;
    graphics = {base = {x = 50 ; y = 50} ; dilat = 20 ; color_arr = init_color()} ; 
    shapes = init_shapes()
    }
;;
*)

(* ----------------------------------------------- *)
(* ----------------------------------------------- *)
(*    Deplacements et controle des deplacements    *)
(* ----------------------------------------------- *)
(* ----------------------------------------------- *)

(* choix des deplacements suivant le caractere saisi *)
(*
let move(pl, dir : t_play * char) : bool = 
  (
  if dir = 't'
    then rotate_right(pl)
    else
      if dir = 'c'
      then rotate_left(pl)
      else
        if dir = 'd'
        then move_left(pl)
        else
          if dir = 'h'
          then move_right(pl)
          else () ;  
  (dir = 'v')
  )
;;
*)


(* ----------------------------------- *)
(* ----------------------------------- *)
(*    Suppression des lignes pleines   *)
(* ----------------------------------- *)
(* ----------------------------------- *)


(* --------------------- *)
(* --------------------- *)
(*   Une etape de jeu    *)
(* --------------------- *)
(* --------------------- *)

(*
let newstep(pl, new_t, t, dt : t_play * float ref * float * float) : bool = 
  let the_end : bool ref = ref (!new_t -. t > dt) and dec : bool ref = ref false in
  let dir : char ref = ref 'x' and notmove : bool ref = ref false in
    (
    while not(!the_end)
    do 
      if key_pressed()
      then dir := read_key()
      else () ;
      dec := move(pl, !dir) ;
      dir := 'x' ; 
      new_t := Sys.time() ;
      the_end := !dec || (!new_t -. t > dt) ;
    done ; 
    if !dec 
    then (move_at_bottom(pl) ; notmove := true)
    else notmove := not(move_down(pl)) ;
    if !notmove
    then the_end := final_newstep(pl)
    else the_end := false;
    !the_end ;
    )
;;
*)

(* ------------------------ *)
(* ------------------------ *)
(*    Fonction principale   *)
(* ------------------------ *)
(* ------------------------ *)

(*
let jeuCP2() : unit =
  let pl : t_play = init_play() in
  let t : float ref = ref (Sys.time()) and new_t : float ref = ref (Sys.time()) in
  let dt : float ref = ref (time_init(pl.par)) and t_acc : float ref = ref (Sys.time()) in
  let the_end : bool ref = ref false in
    while not(!the_end)
    do
      the_end := newstep(pl, new_t, !t, !dt) ; 
      if ((!new_t -. !t_acc) > time_extent(pl.par))
      then 
        (
        dt := !dt *. time_ratio(pl.par) ; 
        t_acc := !new_t
        ) 
      else () ;
      t := !new_t
    done
;;
 *)


(* --------------------- *)
(* --------------------- *)
(*      Question 1       *)
(* --------------------- *)
(* --------------------- *)

let draw_absolute_pt(p, base_draw, dilat, col : t_point * t_point * int * t_color) : unit =
  set_color(col);
  draw_rect(base_draw.x + dilat * p.x ,base_draw.x + dilat * p.y, base_draw.x + dilat * (p.x + 1) - 1, base_draw.y + dilat * (p.y + 1) - 1)
;;

let fill_absolute_pt(p, base_draw, dilat, col : t_point * t_point * int * t_color) : unit =
  set_color(col);
  fill_rect(base_draw.x + dilat * p.x ,base_draw.x + dilat * p.y, base_draw.x + dilat * (p.x + 1) - 1, base_draw.y + dilat * (p.y + 1) - 1)
;;

let drawfill_absolute_pt(p, base_draw, dilat, col : t_point * t_point * int * t_color) : unit =
  fill_absolute_pt(p, base_draw, dilat, col);
  draw_absolute_pt(p, base_draw, dilat, black)
;;

                                                                                              
(* --------------------- *)
(* --------------------- *)
(*      Question 2       *)
(* --------------------- *)
(* --------------------- *)

let draw_relative_pt(p, base_point, base_draw, dilat ,col : t_point * t_point * t_point * int * t_color) : unit =
  draw_absolute_pt({x = p.x + base_point.x ; y= p.y + base_point.y}, base_draw, dilat, col)
;;

let fill_relative_pt(p, base_point, base_draw, dilat ,col : t_point * t_point * t_point * int * t_color) : unit =
  fill_absolute_pt(p, {x = p.x + base_point.x ; y = p.y + base_point.y}, base_draw, dilat, col)
;;

let drawfill_relative_pt(p, base_point, base_draw, dilat ,col : t_point * t_point * t_point * int * t_color) : unit =
  drawfill_absolute_pt(p, {x = p.x + base_point.x ; y = p.y + base_point.y}, base_draw, dilat, col)
;;


(* --------------------- *)
(* --------------------- *)
(*      Question 3       *)
(* --------------------- *)
(* --------------------- *)

(*draw_pt_list
trace les contours de plusieurs carr�s pour former les pi�ces
      l est la liste des points d'origine de chaque carr�
      base_point est le point d'origine local
      base_draw est le point d'origine de l'espace d'affichage
      dilat est la longueur d'un carr�
      col est la couleur du contour d'un carr�*)

let draw_pt_list(l, base_pt, base_draw, dilat, col : t_point list * t_point * t_point * int * t_color) : unit =
  for i = 0 to (len(l) - 1)
  do draw_relative_pt(p ,nth(l, i), base_draw, dilat, col)
  done
;;

(*fill_pt_list
trace plusieurs carr�s pleins pour former les pi�ces
      l est la liste des points d'origine de chaque carr�
      base_point est le point d'origine local
      base_draw est le point d'origine de l'espace d'affichage
      dilat est la longueur d'un carr�
      col est la couleur du contour d'un carr�*)

let fill_pt_list(l, base_pt, base_draw, dilat, col : t_point list * t_point * t_point * int * t_color) : unit =
  for i = 0 to (len(l) - 1)
  do draw_relative_pt(p ,nth(l, i), base_draw, dilat, col)
  done
