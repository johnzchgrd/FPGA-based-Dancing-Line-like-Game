module frequency_rom (		
	clk	,
	dout	,
	addr	
	);	
		
	input clk;	
	output [19:0] dout;	
	input [6:0] addr;	
		
	wire [19:0] memory [87:0];	
	reg [19:0] dout;	
		
	always @(posedge clk)	
		dout = memory[addr];
		
/*  It is an old version
	assign memory[	0	] =	{10'd0, 10'd0}	;	// Note:	rest
	assign memory[	1	] =	{10'd9, 10'd395}	;	// Note:	1A
	assign memory[	2	] =	{10'd9, 10'd963}	;	// Note:	1A#Bb
	assign memory[	3	] =	{10'd10, 10'd573}	;	// Note:	1B
	assign memory[	4	] =	{10'd11, 10'd182}	;	// Note:	1C
	assign memory[	5	] =	{10'd11, 10'd838}	;	// Note:	1C#Db
	assign memory[	6	] =	{10'd12, 10'd557}	;	// Note:	1D
	assign memory[	7	] =	{10'd13, 10'd275}	;	// Note:	1D#Eb
	assign memory[	8	] =	{10'd14, 10'd81}	;	// Note:	1E
	assign memory[	9	] =	{10'd14, 10'd912}	;	// Note:	1F
	assign memory[	10	] =	{10'd15, 10'd805}	;	// Note:	1F#Gb
	assign memory[	11	] =	{10'd16, 10'd742}	;	// Note:	1G
	assign memory[	12	] =	{10'd17, 10'd723}	;	// Note:	1G#Ab
	assign memory[	13	] =	{10'd18, 10'd791}	;	// Note:	2A
	assign memory[	14	] =	{10'd19, 10'd903}	;	// Note:	2A#Bb
	assign memory[	15	] =	{10'd21, 10'd122}	;	// Note:	2B
	assign memory[	16	] =	{10'd22, 10'd365}	;	// Note:	2C
	assign memory[	17	] =	{10'd23, 10'd652}	;	// Note:	2C#Db
	assign memory[	18	] =	{10'd25, 10'd90}	;	// Note:	2D
	assign memory[	19	] =	{10'd26, 10'd551}	;	// Note:	2D#Eb
	assign memory[	20	] =	{10'd28, 10'd163}	;	// Note:	2E
	assign memory[	21	] =	{10'd29, 10'd800}	;	// Note:	2F
	assign memory[	22	] =	{10'd31, 10'd587}	;	// Note:	2F#Gb
	assign memory[	23	] =	{10'd33, 10'd461}	;	// Note:	2G
	assign memory[	24	] =	{10'd35, 10'd423}	;	// Note:	2G#Ab
	assign memory[	25	] =	{10'd37, 10'd559}	;	// Note:	3A
	assign memory[	26	] =	{10'd39, 10'd783}	;	// Note:	3A#Bb
	assign memory[	27	] =	{10'd42, 10'd245}	;	// Note:	3B
	assign memory[	28	] =	{10'd44, 10'd731}	;	// Note:	3C
	assign memory[	29	] =	{10'd47, 10'd281}	;	// Note:	3C#Db
	assign memory[	30	] =	{10'd50, 10'd180}	;	// Note:	3D
	assign memory[	31	] =	{10'd53, 10'd79}	;	// Note:	3D#Eb
	assign memory[	32	] =	{10'd56, 10'd327}	;	// Note:	3E
	assign memory[	33	] =	{10'd59, 10'd576}	;	// Note:	3F
	assign memory[	34	] =	{10'd63, 10'd150}	;	// Note:	3F#Gb
	assign memory[	35	] =	{10'd66, 10'd922}	;	// Note:	3G
	assign memory[	36	] =	{10'd70, 10'd846}	;	// Note:	3G#Ab
	assign memory[	37	] =	{10'd75, 10'd95}	;	// Note:	4A
	assign memory[	38	] =	{10'd79, 10'd543}	;	// Note:	4A#Bb
	assign memory[	39	] =	{10'd84, 10'd491}	;	// Note:	4B
	assign memory[	40	] =	{10'd89, 10'd439}	;	// Note:	4C
	assign memory[	41	] =	{10'd94, 10'd562}	;	// Note:	4C#Db
	assign memory[	42	] =	{10'd100, 10'd360}	;	// Note:	4D
	assign memory[	43	] =	{10'd106, 10'd158}	;	// Note:	4D#Eb
	assign memory[	44	] =	{10'd112, 10'd655}	;	// Note:	4E
	assign memory[	45	] =	{10'd119, 10'd128}	;	// Note:	4F
	assign memory[	46	] =	{10'd126, 10'd300}	;	// Note:	4F#Gb
	assign memory[	47	] =	{10'd133, 10'd821}	;	// Note:	4G
	assign memory[	48	] =	{10'd141, 10'd669}	;	// Note:	4G#Ab
	assign memory[	49	] =	{10'd150, 10'd191}	;	// Note:	5A
	assign memory[	50	] =	{10'd159, 10'd62}	;	// Note:	5A#Bb
	assign memory[	51	] =	{10'd168, 10'd983}	;	// Note:	5B
	assign memory[	52	] =	{10'd178, 10'd879}	;	// Note:	5C
	assign memory[	53	] =	{10'd189, 10'd101}	;	// Note:	5C#Db
	assign memory[	54	] =	{10'd200, 10'd720}	;	// Note:	5D
	assign memory[	55	] =	{10'd212, 10'd316}	;	// Note:	5D#Eb
	assign memory[	56	] =	{10'd225, 10'd286}	;	// Note:	5E
	assign memory[	57	] =	{10'd238, 10'd256}	;	// Note:	5F
	assign memory[	58	] =	{10'd252, 10'd600}	;	// Note:	5F#Gb
	assign memory[	59	] =	{10'd267, 10'd619}	;	// Note:	5G
	assign memory[	60	] =	{10'd283, 10'd314}	;	// Note:	5G#Ab
	assign memory[	61	] =	{10'd300, 10'd382}	;	// Note:	6A
	assign memory[	62	] =	{10'd318, 10'd125}	;	// Note:	6A#Bb
	assign memory[	63	] =	{10'd337, 10'd942}	;	// Note:	6B
*/
// the new version
    assign memory[0 ] = {10'd0  , 10'd0  };    //Note: rest
    assign memory[1 ] = {10'd4  , 10'd709};    //Note: 1A
    assign memory[2 ] = {10'd4  , 10'd995};    //Note: 1A#Bb
    assign memory[3 ] = {10'd5  , 10'd274};    //Note: 1B
    assign memory[4 ] = {10'd5  , 10'd595};    //Note: 2C
    assign memory[5 ] = {10'd5  , 10'd935};    //Note: 2C#Db
    assign memory[6 ] = {10'd6  , 10'd271};    //Note: 2D
    assign memory[7 ] = {10'd6  , 10'd652};    //Note: 2D#Eb
    assign memory[8 ] = {10'd7  , 10'd32 };    //Note: 2E
    assign memory[9 ] = {10'd7  , 10'd461};    //Note: 2F
    assign memory[10] = {10'd7  , 10'd914};    //Note: 2F#Gb
    assign memory[11] = {10'd8  , 10'd371};    //Note: 2G
    assign memory[12] = {10'd8  , 10'd880};    //Note: 2G#Ab
    assign memory[13] = {10'd9  , 10'd395};    //Note: 2A
    assign memory[14] = {10'd9  , 10'd967};    //Note: 2A#Bb
    assign memory[15] = {10'd10 , 10'd549};    //Note: 2B
    assign memory[16] = {10'd11 , 10'd166};    //Note: 3C
    assign memory[17] = {10'd11 , 10'd846};    //Note: 3C#Db
    assign memory[18] = {10'd12 , 10'd542};    //Note: 3D
    assign memory[19] = {10'd13 , 10'd281};    //Note: 3D#Eb
    assign memory[20] = {10'd14 , 10'd65 };    //Note: 3E
    assign memory[21] = {10'd14 , 10'd922};    //Note: 3F
    assign memory[22] = {10'd15 , 10'd805};    //Note: 3F#Gb
    assign memory[23] = {10'd16 , 10'd742};    //Note: 3G
    assign memory[24] = {10'd17 , 10'd736};    //Note: 3G#Ab
    assign memory[25] = {10'd18 , 10'd791};    //Note: 3A
    assign memory[26] = {10'd19 , 10'd911};    //Note: 3A#Bb
    assign memory[27] = {10'd21 , 10'd74 };    //Note: 3B
    assign memory[28] = {10'd22 , 10'd333};    //Note: 4C
    assign memory[29] = {10'd23 , 10'd668};    //Note: 4C#Db
    assign memory[30] = {10'd25 , 10'd60 };    //Note: 4D
    assign memory[31] = {10'd26 , 10'd562};    //Note: 4D#Eb
    assign memory[32] = {10'd28 , 10'd131};    //Note: 4E
    assign memory[33] = {10'd29 , 10'd820};    //Note: 4F
    assign memory[34] = {10'd31 , 10'd586};    //Note: 4F#Gb
    assign memory[35] = {10'd33 , 10'd461};    //Note: 4G
    assign memory[36] = {10'd35 , 10'd449};    //Note: 4G#Ab
    assign memory[37] = {10'd37 , 10'd559};    //Note: 4A(440Hz)
    assign memory[38] = {10'd39 , 10'd798};    //Note: 4A#Bb
    assign memory[39] = {10'd42 , 10'd148};    //Note: 4B
    assign memory[40] = {10'd44 , 10'd666};    //Note: 5C
    assign memory[41] = {10'd47 , 10'd313};    //Note: 5C#Db
    assign memory[42] = {10'd50 , 10'd121};    //Note: 5D
    assign memory[43] = {10'd53 , 10'd101};    //Note: 5D#Eb
    assign memory[44] = {10'd56 , 10'd262};    //Note: 5E
    assign memory[45] = {10'd59 , 10'd616};    //Note: 5F
    assign memory[46] = {10'd63 , 10'd149};    //Note: 5F#Gb
    assign memory[47] = {10'd66 , 10'd922};    //Note: 5G
    assign memory[48] = {10'd70 , 10'd899};    //Note: 5G#Ab
    assign memory[49] = {10'd75 , 10'd95 };    //Note: 5A
    assign memory[50] = {10'd79 , 10'd572};    //Note: 5A#Bb
    assign memory[51] = {10'd84 , 10'd296};    //Note: 5B
    assign memory[52] = {10'd89 , 10'd308};    //Note: 6C
    assign memory[53] = {10'd94 , 10'd626};    //Note: 6C#Db
    assign memory[54] = {10'd100, 10'd243};    //Note: 6D
    assign memory[55] = {10'd106, 10'd202};    //Note: 6D#Eb
    assign memory[56] = {10'd112, 10'd525};    //Note: 6E
    assign memory[57] = {10'd119, 10'd208};    //Note: 6F
    assign memory[58] = {10'd126, 10'd298};    //Note: 6F#Gb
    assign memory[59] = {10'd133, 10'd820};    //Note: 6G
    assign memory[60] = {10'd141, 10'd775};    //Note: 6G#Ab
    assign memory[61] = {10'd150, 10'd191};    //Note: 6A
    assign memory[62] = {10'd159, 10'd120};    //Note: 6A#Bb
    assign memory[63] = {10'd168, 10'd592};    //Note: 6B
    assign memory[64] = {10'd178, 10'd617};    //Note: 7C
    assign memory[65] = {10'd189, 10'd228};    //Note: 7C#Db
    assign memory[66] = {10'd200, 10'd486};    //Note: 7D
    assign memory[67] = {10'd212, 10'd405};    //Note: 7D#Eb
    assign memory[68] = {10'd225, 10'd26 };    //Note: 7E
    assign memory[69] = {10'd238, 10'd416};    //Note: 7F
    assign memory[70] = {10'd252, 10'd596};    //Note: 7F#Gb
    assign memory[71] = {10'd267, 10'd616};    //Note: 7G
    assign memory[72] = {10'd283, 10'd527};    //Note: 7G#Ab
    assign memory[73] = {10'd300, 10'd382};    //Note: 7A
    assign memory[74] = {10'd318, 10'd240};    //Note: 7A#Bb
    assign memory[75] = {10'd337, 10'd161};    //Note: 7B
    assign memory[76] = {10'd357, 10'd211};    //Note: 8C
    assign memory[77] = {10'd378, 10'd457};    //Note: 8C#Db
    assign memory[78] = {10'd400, 10'd973};    //Note: 8D
    assign memory[79] = {10'd424, 10'd811};    //Note: 8D#Eb
    assign memory[80] = {10'd450, 10'd52 };    //Note: 8E
    assign memory[81] = {10'd476, 10'd832};    //Note: 8F
    assign memory[82] = {10'd505, 10'd169};    //Note: 8F#Gb
    assign memory[83] = {10'd535, 10'd209};    //Note: 8G
    assign memory[84] = {10'd567, 10'd30 };    //Note: 8G#Ab
    assign memory[85] = {10'd600, 10'd764};    //Note: 8A
    assign memory[86] = {10'd636, 10'd480};    //Note: 8A#Bb
    assign memory[87] = {10'd674, 10'd322};    //Note: 8B
    assign memory[88] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[89] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[90] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[91] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[92] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[93] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[94] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[95] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[96] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[97] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[98] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[99] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[100] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[101] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[102] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[103] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[104] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[105] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[106] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[107] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[108] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[109] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[110] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[111] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[112] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[113] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[114] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[115] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[116] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[117] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[118] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[119] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[120] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[121] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[122] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[123] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[124] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[125] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[126] = {10'd0  , 10'd0  };    //Note: NULL
    assign memory[127] = {10'd0  , 10'd0  };    //Note: NULL
endmodule							
