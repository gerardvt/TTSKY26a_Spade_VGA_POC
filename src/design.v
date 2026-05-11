`ifdef COCOTB_SIM
    `define COCOTB_CODE(name) \
        string __top_module; \
        string __vcd_file; \
        initial begin \
            if ($value$plusargs("TOP_MODULE=%s", __top_module) && __top_module == `"name`" && $value$plusargs("VCD_FILENAME=%s", __vcd_file)) begin \
                $dumpfile (__vcd_file); \
                $dumpvars (0, \name ); \
            end \
        end
`else
    `define COCOTB_CODE(name)
`endif


module \std::cdc::sync2[1458]  (
        input clk_i,
        input input_i,
        output output__
    );
    `COCOTB_CODE( std::cdc::sync2[1458] )
    logic \clk ;
    assign \clk  = clk_i;
    logic \input ;
    assign \input  = input_i;
    (* src = "<compiler dir>/stdlib/cdc.spade:14,14" *)
    reg \sync1 ;
    (* src = "<compiler dir>/stdlib/cdc.spade:15,14" *)
    reg \sync2 ;
    always @(posedge \clk ) begin
        \sync1  <= \input ;
    end
    always @(posedge \clk ) begin
        \sync2  <= \sync1 ;
    end
    assign output__ = \sync2 ;
endmodule


module \std::cdc::sync2_bool  (
        input clk_i,
        input input_i,
        output output__
    );
    `COCOTB_CODE( std::cdc::sync2_bool )
    logic \clk ;
    assign \clk  = clk_i;
    logic \input ;
    assign \input  = input_i;
    (* src = "<compiler dir>/stdlib/cdc.spade:31,14" *)
    logic _e_540;
    (* src = "<compiler dir>/stdlib/cdc.spade:31,14" *)
    
    \std::cdc::sync2[1458]  \sync2_0 (.clk_i(\clk ), .input_i(\input ), .output__(_e_540));
    assign output__ = _e_540;
endmodule


module \std::conv::tri_to_bool  (
        input t_i,
        output output__
    );
    `COCOTB_CODE( std::conv::tri_to_bool )
    logic \t ;
    assign \t  = t_i;
    (* src = "<compiler dir>/stdlib/conv.spade:80,5" *)
    logic _e_824;
    (* src = "<compiler dir>/stdlib/conv.spade:80,5" *)
    
    \std::conv::impl#11::as_bool  \as_bool_0 (.self_i(\t ), .output__(_e_824));
    assign output__ = _e_824;
endmodule


module \std::io::rising_edge  (
        input clk_i,
        input value_i,
        output output__
    );
    `COCOTB_CODE( std::io::rising_edge )
    logic \clk ;
    assign \clk  = clk_i;
    logic \value ;
    assign \value  = value_i;
    (* src = "<compiler dir>/stdlib/io.spade:12,14" *)
    reg \old_value ;
    (* src = "<compiler dir>/core/ops.spade:255,29" *)
    logic _e_2619;
    (* src = "<compiler dir>/core/ops.spade:255,9" *)
    logic _e_2618;
    (* src = "<compiler dir>/core/ops.spade:255,9" *)
    logic _e_2617;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2627;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2628;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2626;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2625;
    always @(posedge \clk ) begin
        \old_value  <= \value ;
    end
    assign _e_2619 = {\old_value };
    assign _e_2618 = ~_e_2619;
    assign _e_2617 = _e_2618;
    assign _e_2627 = {\value };
    assign _e_2628 = {_e_2617};
    assign _e_2626 = _e_2627 & _e_2628;
    assign _e_2625 = _e_2626;
    assign output__ = _e_2625;
endmodule


module \std::io::falling_edge  (
        input clk_i,
        input value_i,
        output output__
    );
    `COCOTB_CODE( std::io::falling_edge )
    logic \clk ;
    assign \clk  = clk_i;
    logic \value ;
    assign \value  = value_i;
    (* src = "<compiler dir>/stdlib/io.spade:27,14" *)
    reg \old_value ;
    (* src = "<compiler dir>/core/ops.spade:255,29" *)
    logic _e_2637;
    (* src = "<compiler dir>/core/ops.spade:255,9" *)
    logic _e_2636;
    (* src = "<compiler dir>/core/ops.spade:255,9" *)
    logic _e_979;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2645;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2646;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2644;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2643;
    always @(posedge \clk ) begin
        \old_value  <= \value ;
    end
    assign _e_2637 = {\value };
    assign _e_2636 = ~_e_2637;
    assign _e_979 = _e_2636;
    assign _e_2645 = {_e_979};
    assign _e_2646 = {\old_value };
    assign _e_2644 = _e_2645 & _e_2646;
    assign _e_2643 = _e_2644;
    assign output__ = _e_2643;
endmodule


module gvt_core (
        input clk,
        input rst_n,
        input ena,
        input[7:0] ui_in,
        input[7:0] uio_in,
        output[7:0] uo_out,
        output[7:0] uio_out,
        output[7:0] uio_oe
    );
    `COCOTB_CODE( gvt_core )
    logic[7:0] \uo_out_mut ;
    assign uo_out = \uo_out_mut ;
    logic[7:0] \uio_out_mut ;
    assign uio_out = \uio_out_mut ;
    logic[7:0] \uio_oe_mut ;
    assign uio_oe = \uio_oe_mut ;
    (* src = "<compiler dir>/core/ops.spade:255,29" *)
    logic _e_2655;
    (* src = "<compiler dir>/core/ops.spade:255,9" *)
    logic _e_2654;
    (* src = "<compiler dir>/core/ops.spade:255,9" *)
    logic \do_reset ;
    (* src = "src/main.spade:25,22" *)
    logic[23:0] \timing ;
    (* src = "src/main.spade:26,22" *)
    logic[9:0] \hcount ;
    (* src = "src/main.spade:27,22" *)
    logic[9:0] \vcount ;
    (* src = "src/main.spade:28,22" *)
    logic \frame_end ;
    (* src = "src/main.spade:29,22" *)
    logic \hsync ;
    (* src = "src/main.spade:30,22" *)
    logic \vsync ;
    (* src = "src/main.spade:31,22" *)
    logic \display_on ;
    localparam[7:0] _e_1687 = 1;
    logic[7:0] \lhs ;
    logic[7:0] \rhs ;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[7:0] _e_2664;
    logic[7:0] _e_2663;
    localparam[7:0] _e_1688 = 0;
    (* src = "<compiler dir>/core/ops.spade:58,9" *)
    logic \pause ;
    localparam[7:0] _e_1694 = 1;
    (* src = "src/main.spade:35,34" *)
    logic[7:0] _e_1692;
    localparam[7:0] _e_1695 = 3;
    logic[7:0] lhs_n1;
    logic[7:0] rhs_n1;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[7:0] _e_2674;
    logic[7:0] _e_1691;
    (* src = "src/main.spade:35,28" *)
    logic[1:0] \pattern ;
    localparam[7:0] _e_1701 = 3;
    (* src = "src/main.spade:36,34" *)
    logic[7:0] _e_1699;
    localparam[7:0] _e_1702 = 3;
    logic[7:0] lhs_n2;
    logic[7:0] rhs_n2;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[7:0] _e_2682;
    logic[7:0] _e_1698;
    (* src = "src/main.spade:36,28" *)
    logic[1:0] \speed ;
    localparam[7:0] _e_1707 = 32;
    logic[7:0] lhs_n3;
    logic[7:0] rhs_n3;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[7:0] _e_2690;
    logic[7:0] _e_2689;
    localparam[7:0] _e_1708 = 0;
    (* src = "<compiler dir>/core/ops.spade:58,9" *)
    logic \invert ;
    localparam[7:0] _e_1713 = 6;
    (* src = "src/main.spade:38,34" *)
    logic[7:0] _e_1711;
    (* src = "src/main.spade:38,28" *)
    logic[1:0] \rot ;
    localparam[1:0] _e_1718 = 3;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_2697;
    localparam[7:0] _e_1720 = 8;
    localparam[1:0] _e_1724 = 2;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_2699;
    localparam[7:0] _e_1726 = 4;
    localparam[1:0] _e_1730 = 1;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_2701;
    localparam[7:0] _e_1732 = 2;
    localparam[7:0] _e_1734 = 1;
    (* src = "src/main.spade:44,14" *)
    logic[7:0] _e_1727;
    (* src = "src/main.spade:43,14" *)
    logic[7:0] _e_1721;
    (* src = "src/main.spade:42,9" *)
    logic[7:0] \step ;
    localparam[7:0] _e_1739 = 0;
    (* src = "<compiler dir>/core/ops.spade:255,29" *)
    logic _e_2705;
    (* src = "<compiler dir>/core/ops.spade:255,9" *)
    logic _e_2704;
    (* src = "<compiler dir>/core/ops.spade:255,9" *)
    logic _e_1743;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2713;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2714;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2712;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2711;
    (* src = "src/main.spade:49,40" *)
    logic[8:0] _e_1747;
    (* src = "src/main.spade:49,34" *)
    logic[7:0] _e_1746;
    (* src = "src/main.spade:49,9" *)
    logic[7:0] _e_1740;
    (* src = "src/main.spade:48,14" *)
    reg[7:0] \frame_ctr ;
    (* src = "src/main.spade:52,23" *)
    logic[7:0] \hx ;
    (* src = "src/main.spade:53,23" *)
    logic[7:0] \vy ;
    (* src = "src/main.spade:54,29" *)
    logic[10:0] _e_1759;
    (* src = "src/main.spade:54,23" *)
    logic[7:0] \hv ;
    localparam[1:0] _e_1766 = 3;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_2721;
    logic[7:0] lhs_n4;
    logic[7:0] rhs_n4;
    (* src = "<compiler dir>/core/ops.spade:417,34" *)
    logic[7:0] _e_2726;
    logic[7:0] _e_1769;
    logic[7:0] lhs_n5;
    logic[7:0] rhs_n5;
    (* src = "<compiler dir>/core/ops.spade:417,34" *)
    logic[7:0] _e_2734;
    logic[7:0] _e_2733;
    localparam[1:0] _e_1776 = 2;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_2739;
    logic[7:0] lhs_n6;
    logic[7:0] rhs_n6;
    (* src = "<compiler dir>/core/ops.spade:417,34" *)
    logic[7:0] _e_2744;
    logic[7:0] _e_2743;
    localparam[1:0] _e_1784 = 1;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_1782;
    logic[7:0] lhs_n7;
    logic[7:0] rhs_n7;
    (* src = "<compiler dir>/core/ops.spade:417,34" *)
    logic[7:0] _e_2754;
    logic[7:0] _e_2753;
    (* src = "src/main.spade:60,14" *)
    logic[7:0] _e_1781;
    (* src = "src/main.spade:59,14" *)
    logic[7:0] _e_1773;
    (* src = "src/main.spade:58,9" *)
    logic[7:0] \base_val ;
    logic[7:0] lhs_n8;
    logic[7:0] rhs_n8;
    (* src = "<compiler dir>/core/ops.spade:417,34" *)
    logic[7:0] _e_2762;
    logic[7:0] \raw ;
    localparam[7:0] _e_1801 = 255;
    logic[7:0] lhs_n9;
    logic[7:0] rhs_n9;
    (* src = "<compiler dir>/core/ops.spade:417,34" *)
    logic[7:0] _e_2770;
    logic[7:0] _e_2769;
    (* src = "src/main.spade:65,29" *)
    logic[7:0] \animated ;
    localparam[7:0] _e_1808 = 6;
    (* src = "src/main.spade:68,32" *)
    logic[7:0] _e_1806;
    (* src = "src/main.spade:68,26" *)
    logic[1:0] \pair3 ;
    localparam[7:0] _e_1814 = 4;
    (* src = "src/main.spade:69,32" *)
    logic[7:0] _e_1812;
    localparam[7:0] _e_1815 = 3;
    logic[7:0] lhs_n10;
    logic[7:0] rhs_n10;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[7:0] _e_2778;
    logic[7:0] _e_2777;
    (* src = "src/main.spade:69,26" *)
    logic[1:0] \pair2 ;
    localparam[7:0] _e_1821 = 2;
    (* src = "src/main.spade:70,32" *)
    logic[7:0] _e_1819;
    localparam[7:0] _e_1822 = 3;
    logic[7:0] lhs_n11;
    logic[7:0] rhs_n11;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[7:0] _e_2786;
    logic[7:0] _e_1818;
    (* src = "src/main.spade:70,26" *)
    logic[1:0] \pair1 ;
    localparam[7:0] _e_1827 = 3;
    logic[7:0] lhs_n12;
    logic[7:0] rhs_n12;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[7:0] _e_2794;
    logic[7:0] _e_2793;
    (* src = "src/main.spade:71,26" *)
    logic[1:0] \pair0 ;
    localparam[1:0] _e_1832 = 3;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_1830;
    localparam[1:0] _e_1838 = 2;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_2801;
    localparam[1:0] _e_1844 = 1;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_1842;
    (* src = "src/main.spade:75,67" *)
    logic[1:0] _e_1841;
    (* src = "src/main.spade:75,38" *)
    logic[1:0] _e_1835;
    (* src = "src/main.spade:75,9" *)
    logic[1:0] \r_pair ;
    localparam[1:0] _e_1853 = 3;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_2805;
    localparam[1:0] _e_1859 = 2;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_2807;
    localparam[1:0] _e_1865 = 1;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_1863;
    (* src = "src/main.spade:77,67" *)
    logic[1:0] _e_1862;
    (* src = "src/main.spade:77,38" *)
    logic[1:0] _e_1856;
    (* src = "src/main.spade:77,9" *)
    logic[1:0] \g_pair ;
    localparam[1:0] _e_1874 = 3;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_1872;
    localparam[1:0] _e_1880 = 2;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_1878;
    localparam[1:0] _e_1886 = 1;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_2815;
    (* src = "src/main.spade:79,67" *)
    logic[1:0] _e_1883;
    (* src = "src/main.spade:79,38" *)
    logic[1:0] _e_1877;
    (* src = "src/main.spade:79,9" *)
    logic[1:0] \b_pair ;
    localparam[1:0] _e_1897 = 2;
    logic[1:0] lhs_n13;
    logic[1:0] rhs_n13;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[1:0] _e_2820;
    logic[1:0] _e_1895;
    localparam[1:0] _e_1898 = 0;
    (* src = "<compiler dir>/core/ops.spade:58,9" *)
    logic _e_2825;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2829;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2830;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2828;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic \r0 ;
    localparam[1:0] _e_1905 = 1;
    logic[1:0] lhs_n14;
    logic[1:0] rhs_n14;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[1:0] _e_2840;
    logic[1:0] _e_2839;
    localparam[1:0] _e_1906 = 0;
    (* src = "<compiler dir>/core/ops.spade:58,9" *)
    logic _e_1902;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2849;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2850;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2848;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic \r1 ;
    localparam[1:0] _e_1913 = 2;
    logic[1:0] lhs_n15;
    logic[1:0] rhs_n15;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[1:0] _e_2860;
    logic[1:0] _e_1911;
    localparam[1:0] _e_1914 = 0;
    (* src = "<compiler dir>/core/ops.spade:58,9" *)
    logic _e_1910;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2869;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2870;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2868;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic \g0 ;
    localparam[1:0] _e_1921 = 1;
    logic[1:0] lhs_n16;
    logic[1:0] rhs_n16;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[1:0] _e_2880;
    logic[1:0] _e_1919;
    localparam[1:0] _e_1922 = 0;
    (* src = "<compiler dir>/core/ops.spade:58,9" *)
    logic _e_2885;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2889;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2890;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2888;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic \g1 ;
    localparam[1:0] _e_1929 = 2;
    logic[1:0] lhs_n17;
    logic[1:0] rhs_n17;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[1:0] _e_2900;
    logic[1:0] _e_2899;
    localparam[1:0] _e_1930 = 0;
    (* src = "<compiler dir>/core/ops.spade:58,9" *)
    logic _e_1926;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2909;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2910;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2908;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic \b0 ;
    localparam[1:0] _e_1937 = 1;
    logic[1:0] lhs_n18;
    logic[1:0] rhs_n18;
    (* src = "<compiler dir>/core/ops.spade:329,34" *)
    logic[1:0] _e_2920;
    logic[1:0] _e_1935;
    localparam[1:0] _e_1938 = 0;
    (* src = "<compiler dir>/core/ops.spade:58,9" *)
    logic _e_1934;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2929;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2930;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2928;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic \b1 ;
    localparam[7:0] _e_1944 = 0;
    (* src = "<compiler dir>/core/ops.spade:58,9" *)
    logic _e_1942;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2941;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2942;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2940;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic \_unused ;
    (* src = "src/main.spade:91,19" *)
    logic[7:0] _e_1947;
    localparam[7:0] _e_1957 = 0;
    localparam[7:0] _e_1959 = 0;
    assign _e_2655 = {\rst_n };
    assign _e_2654 = ~_e_2655;
    assign \do_reset  = _e_2654;
    (* src = "src/main.spade:25,22" *)
    
    \gvt_design::vga::vga_timing  \vga_timing_0 (.clk_i(\clk ), .do_reset_i(\do_reset ), .output__(\timing ));
    assign \hcount  = \timing [23:14];
    assign \vcount  = \timing [13:4];
    assign \frame_end  = \timing [3];
    assign \hsync  = \timing [2];
    assign \vsync  = \timing [1];
    assign \display_on  = \timing [0];
    assign \lhs  = \ui_in ;
    assign \rhs  = _e_1687;
    assign _e_2664 = \lhs  & \rhs ;
    assign _e_2663 = _e_2664;
    assign \pause  = _e_2663 != _e_1688;
    assign _e_1692 = \ui_in  >> _e_1694;
    assign lhs_n1 = _e_1692;
    assign rhs_n1 = _e_1695;
    assign _e_2674 = lhs_n1 & rhs_n1;
    assign _e_1691 = _e_2674;
    assign \pattern  = _e_1691[1:0];
    assign _e_1699 = \ui_in  >> _e_1701;
    assign lhs_n2 = _e_1699;
    assign rhs_n2 = _e_1702;
    assign _e_2682 = lhs_n2 & rhs_n2;
    assign _e_1698 = _e_2682;
    assign \speed  = _e_1698[1:0];
    assign lhs_n3 = \ui_in ;
    assign rhs_n3 = _e_1707;
    assign _e_2690 = lhs_n3 & rhs_n3;
    assign _e_2689 = _e_2690;
    assign \invert  = _e_2689 != _e_1708;
    assign _e_1711 = \ui_in  >> _e_1713;
    assign \rot  = _e_1711[1:0];
    assign _e_2697 = \speed  == _e_1718;
    assign _e_2699 = \speed  == _e_1724;
    assign _e_2701 = \speed  == _e_1730;
    assign _e_1727 = _e_2701 ? _e_1732 : _e_1734;
    assign _e_1721 = _e_2699 ? _e_1726 : _e_1727;
    assign \step  = _e_2697 ? _e_1720 : _e_1721;
    assign _e_2705 = {\pause };
    assign _e_2704 = ~_e_2705;
    assign _e_1743 = _e_2704;
    assign _e_2713 = {\frame_end };
    assign _e_2714 = {_e_1743};
    assign _e_2712 = _e_2713 & _e_2714;
    assign _e_2711 = _e_2712;
    assign _e_1747 = \frame_ctr  + \step ;
    assign _e_1746 = _e_1747[7:0];
    assign _e_1740 = _e_2711 ? _e_1746 : \frame_ctr ;
    always @(posedge \clk ) begin
        if (\do_reset ) begin
            \frame_ctr  <= _e_1739;
        end
        else begin
            \frame_ctr  <= _e_1740;
        end
    end
    assign \hx  = \hcount [7:0];
    assign \vy  = \vcount [7:0];
    assign _e_1759 = \hcount  + \vcount ;
    assign \hv  = _e_1759[7:0];
    assign _e_2721 = \pattern  == _e_1766;
    assign lhs_n4 = \hx ;
    assign rhs_n4 = \vy ;
    assign _e_2726 = lhs_n4 ^ rhs_n4;
    assign _e_1769 = _e_2726;
    assign lhs_n5 = _e_1769;
    assign rhs_n5 = \hv ;
    assign _e_2734 = lhs_n5 ^ rhs_n5;
    assign _e_2733 = _e_2734;
    assign _e_2739 = \pattern  == _e_1776;
    assign lhs_n6 = \hx ;
    assign rhs_n6 = \hv ;
    assign _e_2744 = lhs_n6 ^ rhs_n6;
    assign _e_2743 = _e_2744;
    assign _e_1782 = \pattern  == _e_1784;
    assign lhs_n7 = \hx ;
    assign rhs_n7 = \vy ;
    assign _e_2754 = lhs_n7 ^ rhs_n7;
    assign _e_2753 = _e_2754;
    assign _e_1781 = _e_1782 ? \hv  : _e_2753;
    assign _e_1773 = _e_2739 ? _e_2743 : _e_1781;
    assign \base_val  = _e_2721 ? _e_2733 : _e_1773;
    assign lhs_n8 = \base_val ;
    assign rhs_n8 = \frame_ctr ;
    assign _e_2762 = lhs_n8 ^ rhs_n8;
    assign \raw  = _e_2762;
    assign lhs_n9 = \raw ;
    assign rhs_n9 = _e_1801;
    assign _e_2770 = lhs_n9 ^ rhs_n9;
    assign _e_2769 = _e_2770;
    assign \animated  = \invert  ? _e_2769 : \raw ;
    assign _e_1806 = \animated  >> _e_1808;
    assign \pair3  = _e_1806[1:0];
    assign _e_1812 = \animated  >> _e_1814;
    assign lhs_n10 = _e_1812;
    assign rhs_n10 = _e_1815;
    assign _e_2778 = lhs_n10 & rhs_n10;
    assign _e_2777 = _e_2778;
    assign \pair2  = _e_2777[1:0];
    assign _e_1819 = \animated  >> _e_1821;
    assign lhs_n11 = _e_1819;
    assign rhs_n11 = _e_1822;
    assign _e_2786 = lhs_n11 & rhs_n11;
    assign _e_1818 = _e_2786;
    assign \pair1  = _e_1818[1:0];
    assign lhs_n12 = \animated ;
    assign rhs_n12 = _e_1827;
    assign _e_2794 = lhs_n12 & rhs_n12;
    assign _e_2793 = _e_2794;
    assign \pair0  = _e_2793[1:0];
    assign _e_1830 = \rot  == _e_1832;
    assign _e_2801 = \rot  == _e_1838;
    assign _e_1842 = \rot  == _e_1844;
    assign _e_1841 = _e_1842 ? \pair2  : \pair3 ;
    assign _e_1835 = _e_2801 ? \pair1  : _e_1841;
    assign \r_pair  = _e_1830 ? \pair0  : _e_1835;
    assign _e_2805 = \rot  == _e_1853;
    assign _e_2807 = \rot  == _e_1859;
    assign _e_1863 = \rot  == _e_1865;
    assign _e_1862 = _e_1863 ? \pair1  : \pair2 ;
    assign _e_1856 = _e_2807 ? \pair0  : _e_1862;
    assign \g_pair  = _e_2805 ? \pair3  : _e_1856;
    assign _e_1872 = \rot  == _e_1874;
    assign _e_1878 = \rot  == _e_1880;
    assign _e_2815 = \rot  == _e_1886;
    assign _e_1883 = _e_2815 ? \pair0  : \pair1 ;
    assign _e_1877 = _e_1878 ? \pair3  : _e_1883;
    assign \b_pair  = _e_1872 ? \pair2  : _e_1877;
    assign lhs_n13 = \r_pair ;
    assign rhs_n13 = _e_1897;
    assign _e_2820 = lhs_n13 & rhs_n13;
    assign _e_1895 = _e_2820;
    assign _e_2825 = _e_1895 != _e_1898;
    assign _e_2829 = {\display_on };
    assign _e_2830 = {_e_2825};
    assign _e_2828 = _e_2829 & _e_2830;
    assign \r0  = _e_2828;
    assign lhs_n14 = \r_pair ;
    assign rhs_n14 = _e_1905;
    assign _e_2840 = lhs_n14 & rhs_n14;
    assign _e_2839 = _e_2840;
    assign _e_1902 = _e_2839 != _e_1906;
    assign _e_2849 = {\display_on };
    assign _e_2850 = {_e_1902};
    assign _e_2848 = _e_2849 & _e_2850;
    assign \r1  = _e_2848;
    assign lhs_n15 = \g_pair ;
    assign rhs_n15 = _e_1913;
    assign _e_2860 = lhs_n15 & rhs_n15;
    assign _e_1911 = _e_2860;
    assign _e_1910 = _e_1911 != _e_1914;
    assign _e_2869 = {\display_on };
    assign _e_2870 = {_e_1910};
    assign _e_2868 = _e_2869 & _e_2870;
    assign \g0  = _e_2868;
    assign lhs_n16 = \g_pair ;
    assign rhs_n16 = _e_1921;
    assign _e_2880 = lhs_n16 & rhs_n16;
    assign _e_1919 = _e_2880;
    assign _e_2885 = _e_1919 != _e_1922;
    assign _e_2889 = {\display_on };
    assign _e_2890 = {_e_2885};
    assign _e_2888 = _e_2889 & _e_2890;
    assign \g1  = _e_2888;
    assign lhs_n17 = \b_pair ;
    assign rhs_n17 = _e_1929;
    assign _e_2900 = lhs_n17 & rhs_n17;
    assign _e_2899 = _e_2900;
    assign _e_1926 = _e_2899 != _e_1930;
    assign _e_2909 = {\display_on };
    assign _e_2910 = {_e_1926};
    assign _e_2908 = _e_2909 & _e_2910;
    assign \b0  = _e_2908;
    assign lhs_n18 = \b_pair ;
    assign rhs_n18 = _e_1937;
    assign _e_2920 = lhs_n18 & rhs_n18;
    assign _e_1935 = _e_2920;
    assign _e_1934 = _e_1935 != _e_1938;
    assign _e_2929 = {\display_on };
    assign _e_2930 = {_e_1934};
    assign _e_2928 = _e_2929 & _e_2930;
    assign \b1  = _e_2928;
    assign _e_1942 = \uio_in  != _e_1944;
    assign _e_2941 = {\ena };
    assign _e_2942 = {_e_1942};
    assign _e_2940 = _e_2941 & _e_2942;
    assign \_unused  = _e_2940;
    assign _e_1947 = {\hsync , \b0 , \g0 , \r0 , \vsync , \b1 , \g1 , \r1 };
    assign \uo_out_mut  = _e_1947;
    assign \uio_out_mut  = _e_1957;
    assign \uio_oe_mut  = _e_1959;
    
endmodule


module \gvt_design::vga::vga_timing  (
        input clk_i,
        input do_reset_i,
        output[23:0] output__
    );
    `COCOTB_CODE( gvt_design::vga::vga_timing )
    logic \clk ;
    assign \clk  = clk_i;
    logic \do_reset ;
    assign \do_reset  = do_reset_i;
    localparam[9:0] _e_1964 = 0;
    localparam[9:0] _e_1968 = 799;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_1966;
    localparam[9:0] _e_1970 = 0;
    localparam[9:0] _e_1975 = 1;
    (* src = "src/vga.spade:39,45" *)
    logic[10:0] _e_1973;
    (* src = "src/vga.spade:39,39" *)
    logic[9:0] _e_1972;
    (* src = "src/vga.spade:39,9" *)
    logic[9:0] _e_1965;
    (* src = "src/vga.spade:38,14" *)
    reg[9:0] \hcount ;
    localparam[9:0] _e_1979 = 0;
    localparam[9:0] _e_1983 = 799;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_1981;
    localparam[9:0] _e_1988 = 524;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_2953;
    localparam[9:0] _e_1990 = 0;
    localparam[9:0] _e_1995 = 1;
    (* src = "src/vga.spade:42,49" *)
    logic[10:0] _e_1993;
    (* src = "src/vga.spade:42,43" *)
    logic[9:0] _e_1992;
    (* src = "src/vga.spade:42,13" *)
    logic[9:0] _e_1985;
    (* src = "src/vga.spade:41,9" *)
    logic[9:0] _e_1980;
    (* src = "src/vga.spade:40,14" *)
    reg[9:0] \vcount ;
    localparam[9:0] _e_2001 = 799;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_2955;
    localparam[9:0] _e_2004 = 524;
    (* src = "<compiler dir>/core/ops.spade:53,9" *)
    logic _e_2957;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2961;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2962;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2960;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic \frame_end ;
    localparam[9:0] _e_2010 = 656;
    (* src = "<compiler dir>/core/ops.spade:469,9" *)
    logic _e_2008;
    localparam[9:0] _e_2013 = 752;
    (* src = "<compiler dir>/core/ops.spade:454,9" *)
    logic _e_2971;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2975;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2976;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2974;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2007;
    (* src = "<compiler dir>/core/ops.spade:255,29" *)
    logic _e_2985;
    (* src = "<compiler dir>/core/ops.spade:255,9" *)
    logic _e_2984;
    (* src = "<compiler dir>/core/ops.spade:255,9" *)
    logic \hsync ;
    localparam[9:0] _e_2019 = 490;
    (* src = "<compiler dir>/core/ops.spade:469,9" *)
    logic _e_2017;
    localparam[9:0] _e_2022 = 492;
    (* src = "<compiler dir>/core/ops.spade:454,9" *)
    logic _e_2020;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_2997;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_2998;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2996;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_2016;
    (* src = "<compiler dir>/core/ops.spade:255,29" *)
    logic _e_3007;
    (* src = "<compiler dir>/core/ops.spade:255,9" *)
    logic _e_3006;
    (* src = "<compiler dir>/core/ops.spade:255,9" *)
    logic \vsync ;
    localparam[9:0] _e_2027 = 640;
    (* src = "<compiler dir>/core/ops.spade:454,9" *)
    logic _e_3013;
    localparam[9:0] _e_2030 = 480;
    (* src = "<compiler dir>/core/ops.spade:454,9" *)
    logic _e_3015;
    (* src = "<compiler dir>/core/ops.spade:297,29" *)
    logic _e_3019;
    (* src = "<compiler dir>/core/ops.spade:297,37" *)
    logic _e_3020;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic _e_3018;
    (* src = "<compiler dir>/core/ops.spade:297,9" *)
    logic \display_on ;
    (* src = "src/vga.spade:52,5" *)
    logic[23:0] _e_2032;
    assign _e_1966 = \hcount  == _e_1968;
    assign _e_1973 = \hcount  + _e_1975;
    assign _e_1972 = _e_1973[9:0];
    assign _e_1965 = _e_1966 ? _e_1970 : _e_1972;
    always @(posedge \clk ) begin
        if (\do_reset ) begin
            \hcount  <= _e_1964;
        end
        else begin
            \hcount  <= _e_1965;
        end
    end
    assign _e_1981 = \hcount  == _e_1983;
    assign _e_2953 = \vcount  == _e_1988;
    assign _e_1993 = \vcount  + _e_1995;
    assign _e_1992 = _e_1993[9:0];
    assign _e_1985 = _e_2953 ? _e_1990 : _e_1992;
    assign _e_1980 = _e_1981 ? _e_1985 : \vcount ;
    always @(posedge \clk ) begin
        if (\do_reset ) begin
            \vcount  <= _e_1979;
        end
        else begin
            \vcount  <= _e_1980;
        end
    end
    assign _e_2955 = \hcount  == _e_2001;
    assign _e_2957 = \vcount  == _e_2004;
    assign _e_2961 = {_e_2955};
    assign _e_2962 = {_e_2957};
    assign _e_2960 = _e_2961 & _e_2962;
    assign \frame_end  = _e_2960;
    assign _e_2008 = \hcount  >= _e_2010;
    assign _e_2971 = \hcount  < _e_2013;
    assign _e_2975 = {_e_2008};
    assign _e_2976 = {_e_2971};
    assign _e_2974 = _e_2975 & _e_2976;
    assign _e_2007 = _e_2974;
    assign _e_2985 = {_e_2007};
    assign _e_2984 = ~_e_2985;
    assign \hsync  = _e_2984;
    assign _e_2017 = \vcount  >= _e_2019;
    assign _e_2020 = \vcount  < _e_2022;
    assign _e_2997 = {_e_2017};
    assign _e_2998 = {_e_2020};
    assign _e_2996 = _e_2997 & _e_2998;
    assign _e_2016 = _e_2996;
    assign _e_3007 = {_e_2016};
    assign _e_3006 = ~_e_3007;
    assign \vsync  = _e_3006;
    assign _e_3013 = \hcount  < _e_2027;
    assign _e_3015 = \vcount  < _e_2030;
    assign _e_3019 = {_e_3013};
    assign _e_3020 = {_e_3015};
    assign _e_3018 = _e_3019 & _e_3020;
    assign \display_on  = _e_3018;
    assign _e_2032 = {\hcount , \vcount , \frame_end , \hsync , \vsync , \display_on };
    assign output__ = _e_2032;
endmodule


module \std::conv::impl#9::as_clock  (
        input self_i,
        output output__
    );
    `COCOTB_CODE( std::conv::impl#9::as_clock )
    logic \self ;
    assign \self  = self_i;
    logic _e_868;
    assign _e_868 = \self ;
    assign output__ = _e_868;
endmodule


module \std::conv::impl#9::as_uint  (
        input self_i,
        output output__
    );
    `COCOTB_CODE( std::conv::impl#9::as_uint )
    logic \self ;
    assign \self  = self_i;
    logic _e_872;
    assign _e_872 = \self ;
    assign output__ = _e_872;
endmodule


module \std::conv::impl#10::as_bool  (
        input self_i,
        output output__
    );
    `COCOTB_CODE( std::conv::impl#10::as_bool )
    logic \self ;
    assign \self  = self_i;
    logic _e_883;
    assign _e_883 = \self ;
    assign output__ = _e_883;
endmodule


module \std::conv::impl#11::as_bool  (
        input self_i,
        output output__
    );
    `COCOTB_CODE( std::conv::impl#11::as_bool )
    logic \self ;
    assign \self  = self_i;
    logic _e_891;
    assign _e_891 = \self ;
    assign output__ = _e_891;
endmodule

`default_nettype none