// This is the unpowered netlist.
module smart_streetlight (clk,
    day_night,
    light_pwm,
    reset,
    vehicle_detect);
 input clk;
 input day_night;
 output light_pwm;
 input reset;
 input vehicle_detect;

 wire _00_;
 wire _01_;
 wire _02_;
 wire _03_;
 wire _04_;
 wire _05_;
 wire _06_;
 wire _07_;
 wire _08_;
 wire _10_;
 wire _12_;
 wire _13_;
 wire _14_;
 wire _15_;
 wire _16_;
 wire _17_;
 wire _18_;
 wire _19_;
 wire _20_;
 wire _21_;
 wire _22_;
 wire _23_;
 wire _24_;
 wire _25_;
 wire _26_;
 wire _27_;
 wire _28_;
 wire _29_;
 wire _30_;
 wire _31_;
 wire _32_;
 wire _33_;
 wire _34_;
 wire _35_;
 wire _36_;
 wire _37_;
 wire _38_;
 wire _39_;
 wire _40_;
 wire clknet_0_clk;
 wire clknet_1_0__leaf_clk;
 wire clknet_1_1__leaf_clk;
 wire \controller.reset ;
 wire \controller.state[0] ;
 wire \controller.state[1] ;
 wire net1;
 wire net10;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire \pwm.counter[0] ;
 wire \pwm.counter[1] ;
 wire \pwm.counter[2] ;
 wire \pwm.counter[3] ;
 wire \pwm.counter[4] ;
 wire \pwm.counter[5] ;
 wire \pwm.counter[6] ;
 wire \pwm.counter[7] ;
 wire \reset_unit.reset_ff[0] ;

 sky130_fd_sc_hd__decap_3 FILLER_0_0_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_0_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_32 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_35 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_44 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_47 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_50 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_53 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_72 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_78 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_0_9 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_10_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_34 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_37 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_40 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_43 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_46 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_49 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_52 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_55 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_58 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_61 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_10_9 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_11_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_11_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_11_40 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_11_43 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_11_46 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_11_49 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_11_52 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_11_55 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_11_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_11_9 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_11_92 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_21 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_12_27 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_12_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_34 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_37 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_40 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_12_43 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_81 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_12_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12_90 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_12_93 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_24 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_51 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_13_54 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_68 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_71 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_74 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_77 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_80 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_83 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_86 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_89 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_13_9 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_13_92 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_14_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_32 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_35 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_14_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_72 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_78 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_14_91 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_15_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_32 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_35 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_44 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_47 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_50 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_53 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_15_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_62 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_65 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_68 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_71 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_74 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_77 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_80 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_15_83 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15_91 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_24 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_1_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_32 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_35 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_44 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_47 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_50 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_53 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_72 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_78 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_84 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_87 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_1_90 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_1_93 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_2_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_2_43 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_2_46 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_2_49 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_2_52 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_2_55 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_2_58 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_2_6 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_2_61 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_2_83 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_2_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_2_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_2_91 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_3_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_3_51 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_3_54 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_3_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_3_6 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_3_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_3_90 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_3_93 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_4_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_4_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_4_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_4_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_4_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_4_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_4_66 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_4_83 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_4_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_4_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_4_91 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_5_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_49 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_52 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_5_55 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_72 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_78 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_84 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_87 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_5_90 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_5_93 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_18 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_6_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_44 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_47 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_50 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_53 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_56 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_59 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_62 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_65 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_68 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_71 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_6_74 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_6_82 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_6_91 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_7_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_36 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_39 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_42 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_45 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_48 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_51 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_7_54 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_72 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_78 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_84 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_87 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_7_90 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_7_93 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_8_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_32 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_8_35 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_78 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_8_91 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_9_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_34 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_37 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_40 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_43 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_46 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_49 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_52 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_9_55 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_66 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_9_69 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_74 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_77 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_80 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_83 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_86 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_89 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_9_9 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_9_92 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_16 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Right_0 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Right_10 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Right_11 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Right_12 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Right_13 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_30 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Right_14 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_31 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Right_15 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_17 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Right_1 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_18 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Right_2 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_19 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Right_3 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_20 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Right_4 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_21 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Right_5 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_22 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Right_6 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_23 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Right_7 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_24 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Right_8 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Right_9 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_32 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_33 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_34 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_54 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_35 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_36 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_37 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_38 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_39 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_40 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_41 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_42 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_43 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_44 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_45 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_47 ();
 sky130_fd_sc_hd__inv_2 _42_ (.A(net2),
    .Y(_10_));
 sky130_fd_sc_hd__inv_2 _43_ (.A(net2),
    .Y(_08_));
 sky130_fd_sc_hd__nand2_1 _44_ (.A(\controller.state[1] ),
    .B(\controller.state[0] ),
    .Y(_24_));
 sky130_fd_sc_hd__o21ai_1 _45_ (.A1(\controller.state[1] ),
    .A2(\controller.state[0] ),
    .B1(net3),
    .Y(_25_));
 sky130_fd_sc_hd__and3_1 _46_ (.A(net1),
    .B(_24_),
    .C(_25_),
    .X(_26_));
 sky130_fd_sc_hd__clkbuf_1 _47_ (.A(_26_),
    .X(_22_));
 sky130_fd_sc_hd__nand2_1 _48_ (.A(net1),
    .B(_24_),
    .Y(_27_));
 sky130_fd_sc_hd__nor2_1 _49_ (.A(_27_),
    .B(_25_),
    .Y(_23_));
 sky130_fd_sc_hd__inv_2 _50_ (.A(net9),
    .Y(_00_));
 sky130_fd_sc_hd__or2_1 _51_ (.A(\pwm.counter[0] ),
    .B(\pwm.counter[1] ),
    .X(_28_));
 sky130_fd_sc_hd__a311o_1 _52_ (.A1(\pwm.counter[3] ),
    .A2(\pwm.counter[2] ),
    .A3(_28_),
    .B1(\pwm.counter[4] ),
    .C1(\pwm.counter[5] ),
    .X(_29_));
 sky130_fd_sc_hd__inv_2 _53_ (.A(\controller.state[0] ),
    .Y(_30_));
 sky130_fd_sc_hd__a211oi_1 _54_ (.A1(\pwm.counter[6] ),
    .A2(_29_),
    .B1(_30_),
    .C1(\pwm.counter[7] ),
    .Y(_31_));
 sky130_fd_sc_hd__o21a_1 _55_ (.A1(\controller.state[1] ),
    .A2(_31_),
    .B1(_24_),
    .X(net4));
 sky130_fd_sc_hd__nand2_1 _56_ (.A(\pwm.counter[0] ),
    .B(\pwm.counter[1] ),
    .Y(_32_));
 sky130_fd_sc_hd__and2_1 _57_ (.A(_28_),
    .B(_32_),
    .X(_33_));
 sky130_fd_sc_hd__clkbuf_1 _58_ (.A(_33_),
    .X(_01_));
 sky130_fd_sc_hd__xnor2_1 _59_ (.A(\pwm.counter[2] ),
    .B(_32_),
    .Y(_02_));
 sky130_fd_sc_hd__and4_1 _60_ (.A(\pwm.counter[0] ),
    .B(\pwm.counter[3] ),
    .C(\pwm.counter[2] ),
    .D(\pwm.counter[1] ),
    .X(_34_));
 sky130_fd_sc_hd__a31o_1 _61_ (.A1(\pwm.counter[0] ),
    .A2(\pwm.counter[2] ),
    .A3(\pwm.counter[1] ),
    .B1(\pwm.counter[3] ),
    .X(_35_));
 sky130_fd_sc_hd__and2b_1 _62_ (.A_N(_34_),
    .B(_35_),
    .X(_36_));
 sky130_fd_sc_hd__clkbuf_1 _63_ (.A(_36_),
    .X(_03_));
 sky130_fd_sc_hd__xor2_1 _64_ (.A(\pwm.counter[4] ),
    .B(_34_),
    .X(_04_));
 sky130_fd_sc_hd__and3_1 _65_ (.A(\pwm.counter[5] ),
    .B(\pwm.counter[4] ),
    .C(_34_),
    .X(_37_));
 sky130_fd_sc_hd__a21oi_1 _66_ (.A1(\pwm.counter[4] ),
    .A2(_34_),
    .B1(\pwm.counter[5] ),
    .Y(_38_));
 sky130_fd_sc_hd__nor2_1 _67_ (.A(_37_),
    .B(_38_),
    .Y(_05_));
 sky130_fd_sc_hd__xor2_1 _68_ (.A(\pwm.counter[6] ),
    .B(_37_),
    .X(_06_));
 sky130_fd_sc_hd__nand2_1 _69_ (.A(\pwm.counter[6] ),
    .B(_37_),
    .Y(_39_));
 sky130_fd_sc_hd__xnor2_1 _70_ (.A(net10),
    .B(_39_),
    .Y(_07_));
 sky130_fd_sc_hd__inv_2 _71__1 (.A(clknet_1_1__leaf_clk),
    .Y(net6));
 sky130_fd_sc_hd__inv_2 _72__2 (.A(clknet_1_1__leaf_clk),
    .Y(net7));
 sky130_fd_sc_hd__buf_4 _73_ (.A(\controller.reset ),
    .X(_40_));
 sky130_fd_sc_hd__inv_2 _74_ (.A(_40_),
    .Y(_12_));
 sky130_fd_sc_hd__inv_2 _75_ (.A(_40_),
    .Y(_13_));
 sky130_fd_sc_hd__inv_2 _76_ (.A(_40_),
    .Y(_14_));
 sky130_fd_sc_hd__inv_2 _77_ (.A(_40_),
    .Y(_15_));
 sky130_fd_sc_hd__inv_2 _78_ (.A(_40_),
    .Y(_16_));
 sky130_fd_sc_hd__inv_2 _79_ (.A(_40_),
    .Y(_17_));
 sky130_fd_sc_hd__inv_2 _80_ (.A(_40_),
    .Y(_18_));
 sky130_fd_sc_hd__inv_2 _81_ (.A(_40_),
    .Y(_19_));
 sky130_fd_sc_hd__inv_2 _82_ (.A(_40_),
    .Y(_20_));
 sky130_fd_sc_hd__inv_2 _83_ (.A(_40_),
    .Y(_21_));
 sky130_fd_sc_hd__dfstp_1 _84_ (.CLK(net6),
    .D(net5),
    .SET_B(_08_),
    .Q(\reset_unit.reset_ff[0] ));
 sky130_fd_sc_hd__conb_1 _84__5 (.LO(net5));
 sky130_fd_sc_hd__dfstp_1 _85_ (.CLK(net7),
    .D(net8),
    .SET_B(_10_),
    .Q(\controller.reset ));
 sky130_fd_sc_hd__dfrtp_1 _86_ (.CLK(clknet_1_0__leaf_clk),
    .D(_22_),
    .RESET_B(_12_),
    .Q(\controller.state[0] ));
 sky130_fd_sc_hd__dfrtp_1 _87_ (.CLK(clknet_1_0__leaf_clk),
    .D(_23_),
    .RESET_B(_13_),
    .Q(\controller.state[1] ));
 sky130_fd_sc_hd__dfrtp_1 _88_ (.CLK(clknet_1_0__leaf_clk),
    .D(_00_),
    .RESET_B(_14_),
    .Q(\pwm.counter[0] ));
 sky130_fd_sc_hd__dfrtp_1 _89_ (.CLK(clknet_1_0__leaf_clk),
    .D(_01_),
    .RESET_B(_15_),
    .Q(\pwm.counter[1] ));
 sky130_fd_sc_hd__dfrtp_1 _90_ (.CLK(clknet_1_0__leaf_clk),
    .D(_02_),
    .RESET_B(_16_),
    .Q(\pwm.counter[2] ));
 sky130_fd_sc_hd__dfrtp_1 _91_ (.CLK(clknet_1_0__leaf_clk),
    .D(_03_),
    .RESET_B(_17_),
    .Q(\pwm.counter[3] ));
 sky130_fd_sc_hd__dfrtp_1 _92_ (.CLK(clknet_1_1__leaf_clk),
    .D(_04_),
    .RESET_B(_18_),
    .Q(\pwm.counter[4] ));
 sky130_fd_sc_hd__dfrtp_1 _93_ (.CLK(clknet_1_1__leaf_clk),
    .D(_05_),
    .RESET_B(_19_),
    .Q(\pwm.counter[5] ));
 sky130_fd_sc_hd__dfrtp_1 _94_ (.CLK(clknet_1_1__leaf_clk),
    .D(_06_),
    .RESET_B(_20_),
    .Q(\pwm.counter[6] ));
 sky130_fd_sc_hd__dfrtp_1 _95_ (.CLK(clknet_1_1__leaf_clk),
    .D(_07_),
    .RESET_B(_21_),
    .Q(\pwm.counter[7] ));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_0__f_clk (.A(clknet_0_clk),
    .X(clknet_1_0__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_1_1__f_clk (.A(clknet_0_clk),
    .X(clknet_1_1__leaf_clk));
 sky130_fd_sc_hd__clkinv_2 clkload0 (.A(clknet_1_0__leaf_clk));
 sky130_fd_sc_hd__dlygate4sd3_1 hold1 (.A(\reset_unit.reset_ff[0] ),
    .X(net8));
 sky130_fd_sc_hd__dlygate4sd3_1 hold2 (.A(\pwm.counter[0] ),
    .X(net9));
 sky130_fd_sc_hd__dlygate4sd3_1 hold3 (.A(\pwm.counter[7] ),
    .X(net10));
 sky130_fd_sc_hd__buf_1 input1 (.A(day_night),
    .X(net1));
 sky130_fd_sc_hd__buf_1 input2 (.A(reset),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_1 input3 (.A(vehicle_detect),
    .X(net3));
 sky130_fd_sc_hd__buf_1 output4 (.A(net4),
    .X(light_pwm));
endmodule

