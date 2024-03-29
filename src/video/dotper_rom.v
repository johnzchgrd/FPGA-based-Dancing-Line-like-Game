`timescale 1ns / 1ps

module dotper_rom_reader(
    input clk,
    input [4:0]x1,
    input [4:0]x2,
    input [4:0]y,
    output [1:0] ui_pixel_type1,
    output [1:0] ui_pixel_type2
    );
    wire [9:0] dpt_in1;
    wire [9:0] dpt_in2;
    dotper_rom dpr1(clk,dpt_in1, ui_pixel_type1);
    dotper_rom dpr2(clk,dpt_in2, ui_pixel_type2);

    assign dpt_in1 = 32*y+x1;
    assign dpt_in2 = 32*y+x2+8;
    
endmodule

module dotper_rom(
    input clk,
    input [9:0]dtr_in,
    output reg[1:0] dout
    );
    wire [1:0] memdotper[767:0];
    always @(posedge clk)begin
        dout = memdotper[dtr_in];
    end
          
    assign memdotper[0   ] = 2'd0;
    assign memdotper[1   ] = 2'd0;
    assign memdotper[2   ] = 2'd0;
    assign memdotper[3   ] = 2'd0;
    assign memdotper[4   ] = 2'd0;
    assign memdotper[5   ] = 2'd0;
    assign memdotper[6   ] = 2'd0;
    assign memdotper[7   ] = 2'd0;
    assign memdotper[8   ] = 2'd0;
    assign memdotper[9   ] = 2'd0;
    assign memdotper[10  ] = 2'd0;
    assign memdotper[11  ] = 2'd2;
    assign memdotper[12  ] = 2'd2;
    assign memdotper[13  ] = 2'd2;
    assign memdotper[14  ] = 2'd2;
    assign memdotper[15  ] = 2'd2;
    assign memdotper[16  ] = 2'd0;
    assign memdotper[17  ] = 2'd0;
    assign memdotper[18  ] = 2'd0;
    assign memdotper[19  ] = 2'd0;
    assign memdotper[20  ] = 2'd0;
    assign memdotper[21  ] = 2'd0;
    assign memdotper[22  ] = 2'd0;
    assign memdotper[23  ] = 2'd0;
    assign memdotper[24  ] = 2'd0;
    assign memdotper[25  ] = 2'd2;
    assign memdotper[26  ] = 2'd2;
    assign memdotper[27  ] = 2'd2;
    assign memdotper[28  ] = 2'd0;
    assign memdotper[29  ] = 2'd0;
    assign memdotper[30  ] = 2'd0;
    assign memdotper[31  ] = 2'd0;
    assign memdotper[32  ] = 2'd0;
    assign memdotper[33  ] = 2'd0;
    assign memdotper[34  ] = 2'd0;
    assign memdotper[35  ] = 2'd0;
    assign memdotper[36  ] = 2'd0;
    assign memdotper[37  ] = 2'd0;
    assign memdotper[38  ] = 2'd0;
    assign memdotper[39  ] = 2'd0;
    assign memdotper[40  ] = 2'd0;
    assign memdotper[41  ] = 2'd0;
    assign memdotper[42  ] = 2'd2;
    assign memdotper[43  ] = 2'd2;
    assign memdotper[44  ] = 2'd2;
    assign memdotper[45  ] = 2'd2;
    assign memdotper[46  ] = 2'd2;
    assign memdotper[47  ] = 2'd2;
    assign memdotper[48  ] = 2'd2;
    assign memdotper[49  ] = 2'd0;
    assign memdotper[50  ] = 2'd0;
    assign memdotper[51  ] = 2'd0;
    assign memdotper[52  ] = 2'd0;
    assign memdotper[53  ] = 2'd0;
    assign memdotper[54  ] = 2'd0;
    assign memdotper[55  ] = 2'd0;
    assign memdotper[56  ] = 2'd2;
    assign memdotper[57  ] = 2'd2;
    assign memdotper[58  ] = 2'd2;
    assign memdotper[59  ] = 2'd1;
    assign memdotper[60  ] = 2'd1;
    assign memdotper[61  ] = 2'd0;
    assign memdotper[62  ] = 2'd0;
    assign memdotper[63  ] = 2'd0;
    assign memdotper[64  ] = 2'd0;
    assign memdotper[65  ] = 2'd0;
    assign memdotper[66  ] = 2'd0;
    assign memdotper[67  ] = 2'd0;
    assign memdotper[68  ] = 2'd0;
    assign memdotper[69  ] = 2'd0;
    assign memdotper[70  ] = 2'd0;
    assign memdotper[71  ] = 2'd0;
    assign memdotper[72  ] = 2'd0;
    assign memdotper[73  ] = 2'd2;
    assign memdotper[74  ] = 2'd2;
    assign memdotper[75  ] = 2'd2;
    assign memdotper[76  ] = 2'd1;
    assign memdotper[77  ] = 2'd1;
    assign memdotper[78  ] = 2'd1;
    assign memdotper[79  ] = 2'd2;
    assign memdotper[80  ] = 2'd2;
    assign memdotper[81  ] = 2'd2;
    assign memdotper[82  ] = 2'd0;
    assign memdotper[83  ] = 2'd0;
    assign memdotper[84  ] = 2'd0;
    assign memdotper[85  ] = 2'd0;
    assign memdotper[86  ] = 2'd0;
    assign memdotper[87  ] = 2'd0;
    assign memdotper[88  ] = 2'd2;
    assign memdotper[89  ] = 2'd2;
    assign memdotper[90  ] = 2'd1;
    assign memdotper[91  ] = 2'd1;
    assign memdotper[92  ] = 2'd0;
    assign memdotper[93  ] = 2'd0;
    assign memdotper[94  ] = 2'd0;
    assign memdotper[95  ] = 2'd0;
    assign memdotper[96  ] = 2'd0;
    assign memdotper[97  ] = 2'd0;
    assign memdotper[98  ] = 2'd0;
    assign memdotper[99  ] = 2'd0;
    assign memdotper[100 ] = 2'd0;
    assign memdotper[101 ] = 2'd0;
    assign memdotper[102 ] = 2'd0;
    assign memdotper[103 ] = 2'd0;
    assign memdotper[104 ] = 2'd2;
    assign memdotper[105 ] = 2'd2;
    assign memdotper[106 ] = 2'd2;
    assign memdotper[107 ] = 2'd1;
    assign memdotper[108 ] = 2'd1;
    assign memdotper[109 ] = 2'd0;
    assign memdotper[110 ] = 2'd0;
    assign memdotper[111 ] = 2'd0;
    assign memdotper[112 ] = 2'd2;
    assign memdotper[113 ] = 2'd2;
    assign memdotper[114 ] = 2'd2;
    assign memdotper[115 ] = 2'd0;
    assign memdotper[116 ] = 2'd0;
    assign memdotper[117 ] = 2'd0;
    assign memdotper[118 ] = 2'd0;
    assign memdotper[119 ] = 2'd2;
    assign memdotper[120 ] = 2'd2;
    assign memdotper[121 ] = 2'd2;
    assign memdotper[122 ] = 2'd1;
    assign memdotper[123 ] = 2'd0;
    assign memdotper[124 ] = 2'd0;
    assign memdotper[125 ] = 2'd0;
    assign memdotper[126 ] = 2'd0;
    assign memdotper[127 ] = 2'd0;
    assign memdotper[128 ] = 2'd0;
    assign memdotper[129 ] = 2'd0;
    assign memdotper[130 ] = 2'd0;
    assign memdotper[131 ] = 2'd0;
    assign memdotper[132 ] = 2'd0;
    assign memdotper[133 ] = 2'd0;
    assign memdotper[134 ] = 2'd0;
    assign memdotper[135 ] = 2'd0;
    assign memdotper[136 ] = 2'd2;
    assign memdotper[137 ] = 2'd2;
    assign memdotper[138 ] = 2'd1;
    assign memdotper[139 ] = 2'd1;
    assign memdotper[140 ] = 2'd0;
    assign memdotper[141 ] = 2'd0;
    assign memdotper[142 ] = 2'd0;
    assign memdotper[143 ] = 2'd0;
    assign memdotper[144 ] = 2'd0;
    assign memdotper[145 ] = 2'd2;
    assign memdotper[146 ] = 2'd2;
    assign memdotper[147 ] = 2'd0;
    assign memdotper[148 ] = 2'd0;
    assign memdotper[149 ] = 2'd0;
    assign memdotper[150 ] = 2'd0;
    assign memdotper[151 ] = 2'd2;
    assign memdotper[152 ] = 2'd2;
    assign memdotper[153 ] = 2'd1;
    assign memdotper[154 ] = 2'd1;
    assign memdotper[155 ] = 2'd0;
    assign memdotper[156 ] = 2'd0;
    assign memdotper[157 ] = 2'd0;
    assign memdotper[158 ] = 2'd0;
    assign memdotper[159 ] = 2'd0;
    assign memdotper[160 ] = 2'd0;
    assign memdotper[161 ] = 2'd0;
    assign memdotper[162 ] = 2'd0;
    assign memdotper[163 ] = 2'd0;
    assign memdotper[164 ] = 2'd0;
    assign memdotper[165 ] = 2'd0;
    assign memdotper[166 ] = 2'd0;
    assign memdotper[167 ] = 2'd0;
    assign memdotper[168 ] = 2'd2;
    assign memdotper[169 ] = 2'd2;
    assign memdotper[170 ] = 2'd1;
    assign memdotper[171 ] = 2'd0;
    assign memdotper[172 ] = 2'd0;
    assign memdotper[173 ] = 2'd0;
    assign memdotper[174 ] = 2'd0;
    assign memdotper[175 ] = 2'd0;
    assign memdotper[176 ] = 2'd0;
    assign memdotper[177 ] = 2'd2;
    assign memdotper[178 ] = 2'd2;
    assign memdotper[179 ] = 2'd1;
    assign memdotper[180 ] = 2'd0;
    assign memdotper[181 ] = 2'd0;
    assign memdotper[182 ] = 2'd2;
    assign memdotper[183 ] = 2'd2;
    assign memdotper[184 ] = 2'd1;
    assign memdotper[185 ] = 2'd1;
    assign memdotper[186 ] = 2'd0;
    assign memdotper[187 ] = 2'd0;
    assign memdotper[188 ] = 2'd0;
    assign memdotper[189 ] = 2'd0;
    assign memdotper[190 ] = 2'd0;
    assign memdotper[191 ] = 2'd0;
    assign memdotper[192 ] = 2'd0;
    assign memdotper[193 ] = 2'd0;
    assign memdotper[194 ] = 2'd0;
    assign memdotper[195 ] = 2'd0;
    assign memdotper[196 ] = 2'd0;
    assign memdotper[197 ] = 2'd0;
    assign memdotper[198 ] = 2'd0;
    assign memdotper[199 ] = 2'd0;
    assign memdotper[200 ] = 2'd2;
    assign memdotper[201 ] = 2'd2;
    assign memdotper[202 ] = 2'd1;
    assign memdotper[203 ] = 2'd0;
    assign memdotper[204 ] = 2'd0;
    assign memdotper[205 ] = 2'd0;
    assign memdotper[206 ] = 2'd0;
    assign memdotper[207 ] = 2'd0;
    assign memdotper[208 ] = 2'd0;
    assign memdotper[209 ] = 2'd2;
    assign memdotper[210 ] = 2'd2;
    assign memdotper[211 ] = 2'd1;
    assign memdotper[212 ] = 2'd0;
    assign memdotper[213 ] = 2'd2;
    assign memdotper[214 ] = 2'd2;
    assign memdotper[215 ] = 2'd2;
    assign memdotper[216 ] = 2'd1;
    assign memdotper[217 ] = 2'd0;
    assign memdotper[218 ] = 2'd0;
    assign memdotper[219 ] = 2'd0;
    assign memdotper[220 ] = 2'd0;
    assign memdotper[221 ] = 2'd0;
    assign memdotper[222 ] = 2'd0;
    assign memdotper[223 ] = 2'd0;
    assign memdotper[224 ] = 2'd0;
    assign memdotper[225 ] = 2'd0;
    assign memdotper[226 ] = 2'd0;
    assign memdotper[227 ] = 2'd0;
    assign memdotper[228 ] = 2'd0;
    assign memdotper[229 ] = 2'd0;
    assign memdotper[230 ] = 2'd0;
    assign memdotper[231 ] = 2'd0;
    assign memdotper[232 ] = 2'd2;
    assign memdotper[233 ] = 2'd2;
    assign memdotper[234 ] = 2'd2;
    assign memdotper[235 ] = 2'd0;
    assign memdotper[236 ] = 2'd0;
    assign memdotper[237 ] = 2'd0;
    assign memdotper[238 ] = 2'd0;
    assign memdotper[239 ] = 2'd0;
    assign memdotper[240 ] = 2'd2;
    assign memdotper[241 ] = 2'd2;
    assign memdotper[242 ] = 2'd2;
    assign memdotper[243 ] = 2'd1;
    assign memdotper[244 ] = 2'd0;
    assign memdotper[245 ] = 2'd2;
    assign memdotper[246 ] = 2'd2;
    assign memdotper[247 ] = 2'd1;
    assign memdotper[248 ] = 2'd1;
    assign memdotper[249 ] = 2'd0;
    assign memdotper[250 ] = 2'd0;
    assign memdotper[251 ] = 2'd0;
    assign memdotper[252 ] = 2'd0;
    assign memdotper[253 ] = 2'd0;
    assign memdotper[254 ] = 2'd0;
    assign memdotper[255 ] = 2'd0;
    assign memdotper[256 ] = 2'd0;
    assign memdotper[257 ] = 2'd0;
    assign memdotper[258 ] = 2'd0;
    assign memdotper[259 ] = 2'd0;
    assign memdotper[260 ] = 2'd0;
    assign memdotper[261 ] = 2'd0;
    assign memdotper[262 ] = 2'd0;
    assign memdotper[263 ] = 2'd0;
    assign memdotper[264 ] = 2'd0;
    assign memdotper[265 ] = 2'd2;
    assign memdotper[266 ] = 2'd2;
    assign memdotper[267 ] = 2'd2;
    assign memdotper[268 ] = 2'd0;
    assign memdotper[269 ] = 2'd0;
    assign memdotper[270 ] = 2'd0;
    assign memdotper[271 ] = 2'd2;
    assign memdotper[272 ] = 2'd2;
    assign memdotper[273 ] = 2'd2;
    assign memdotper[274 ] = 2'd1;
    assign memdotper[275 ] = 2'd1;
    assign memdotper[276 ] = 2'd2;
    assign memdotper[277 ] = 2'd2;
    assign memdotper[278 ] = 2'd1;
    assign memdotper[279 ] = 2'd1;
    assign memdotper[280 ] = 2'd0;
    assign memdotper[281 ] = 2'd0;
    assign memdotper[282 ] = 2'd0;
    assign memdotper[283 ] = 2'd0;
    assign memdotper[284 ] = 2'd0;
    assign memdotper[285 ] = 2'd0;
    assign memdotper[286 ] = 2'd0;
    assign memdotper[287 ] = 2'd0;
    assign memdotper[288 ] = 2'd0;
    assign memdotper[289 ] = 2'd0;
    assign memdotper[290 ] = 2'd0;
    assign memdotper[291 ] = 2'd0;
    assign memdotper[292 ] = 2'd0;
    assign memdotper[293 ] = 2'd0;
    assign memdotper[294 ] = 2'd0;
    assign memdotper[295 ] = 2'd0;
    assign memdotper[296 ] = 2'd0;
    assign memdotper[297 ] = 2'd0;
    assign memdotper[298 ] = 2'd2;
    assign memdotper[299 ] = 2'd2;
    assign memdotper[300 ] = 2'd2;
    assign memdotper[301 ] = 2'd2;
    assign memdotper[302 ] = 2'd2;
    assign memdotper[303 ] = 2'd2;
    assign memdotper[304 ] = 2'd2;
    assign memdotper[305 ] = 2'd1;
    assign memdotper[306 ] = 2'd1;
    assign memdotper[307 ] = 2'd2;
    assign memdotper[308 ] = 2'd2;
    assign memdotper[309 ] = 2'd2;
    assign memdotper[310 ] = 2'd1;
    assign memdotper[311 ] = 2'd0;
    assign memdotper[312 ] = 2'd0;
    assign memdotper[313 ] = 2'd0;
    assign memdotper[314 ] = 2'd0;
    assign memdotper[315 ] = 2'd0;
    assign memdotper[316 ] = 2'd0;
    assign memdotper[317 ] = 2'd0;
    assign memdotper[318 ] = 2'd0;
    assign memdotper[319 ] = 2'd0;
    assign memdotper[320 ] = 2'd0;
    assign memdotper[321 ] = 2'd0;
    assign memdotper[322 ] = 2'd0;
    assign memdotper[323 ] = 2'd0;
    assign memdotper[324 ] = 2'd0;
    assign memdotper[325 ] = 2'd0;
    assign memdotper[326 ] = 2'd0;
    assign memdotper[327 ] = 2'd0;
    assign memdotper[328 ] = 2'd0;
    assign memdotper[329 ] = 2'd0;
    assign memdotper[330 ] = 2'd0;
    assign memdotper[331 ] = 2'd2;
    assign memdotper[332 ] = 2'd2;
    assign memdotper[333 ] = 2'd2;
    assign memdotper[334 ] = 2'd2;
    assign memdotper[335 ] = 2'd2;
    assign memdotper[336 ] = 2'd1;
    assign memdotper[337 ] = 2'd1;
    assign memdotper[338 ] = 2'd0;
    assign memdotper[339 ] = 2'd2;
    assign memdotper[340 ] = 2'd2;
    assign memdotper[341 ] = 2'd1;
    assign memdotper[342 ] = 2'd1;
    assign memdotper[343 ] = 2'd0;
    assign memdotper[344 ] = 2'd0;
    assign memdotper[345 ] = 2'd0;
    assign memdotper[346 ] = 2'd0;
    assign memdotper[347 ] = 2'd0;
    assign memdotper[348 ] = 2'd0;
    assign memdotper[349 ] = 2'd0;
    assign memdotper[350 ] = 2'd0;
    assign memdotper[351 ] = 2'd0;
    assign memdotper[352 ] = 2'd0;
    assign memdotper[353 ] = 2'd0;
    assign memdotper[354 ] = 2'd0;
    assign memdotper[355 ] = 2'd0;
    assign memdotper[356 ] = 2'd0;
    assign memdotper[357 ] = 2'd0;
    assign memdotper[358 ] = 2'd0;
    assign memdotper[359 ] = 2'd0;
    assign memdotper[360 ] = 2'd0;
    assign memdotper[361 ] = 2'd0;
    assign memdotper[362 ] = 2'd0;
    assign memdotper[363 ] = 2'd0;
    assign memdotper[364 ] = 2'd1;
    assign memdotper[365 ] = 2'd1;
    assign memdotper[366 ] = 2'd1;
    assign memdotper[367 ] = 2'd1;
    assign memdotper[368 ] = 2'd1;
    assign memdotper[369 ] = 2'd0;
    assign memdotper[370 ] = 2'd2;
    assign memdotper[371 ] = 2'd2;
    assign memdotper[372 ] = 2'd1;
    assign memdotper[373 ] = 2'd1;
    assign memdotper[374 ] = 2'd0;
    assign memdotper[375 ] = 2'd0;
    assign memdotper[376 ] = 2'd0;
    assign memdotper[377 ] = 2'd0;
    assign memdotper[378 ] = 2'd0;
    assign memdotper[379 ] = 2'd0;
    assign memdotper[380 ] = 2'd0;
    assign memdotper[381 ] = 2'd0;
    assign memdotper[382 ] = 2'd0;
    assign memdotper[383 ] = 2'd0;
    assign memdotper[384 ] = 2'd0;
    assign memdotper[385 ] = 2'd0;
    assign memdotper[386 ] = 2'd0;
    assign memdotper[387 ] = 2'd0;
    assign memdotper[388 ] = 2'd0;
    assign memdotper[389 ] = 2'd0;
    assign memdotper[390 ] = 2'd0;
    assign memdotper[391 ] = 2'd0;
    assign memdotper[392 ] = 2'd0;
    assign memdotper[393 ] = 2'd0;
    assign memdotper[394 ] = 2'd0;
    assign memdotper[395 ] = 2'd0;
    assign memdotper[396 ] = 2'd0;
    assign memdotper[397 ] = 2'd0;
    assign memdotper[398 ] = 2'd0;
    assign memdotper[399 ] = 2'd0;
    assign memdotper[400 ] = 2'd0;
    assign memdotper[401 ] = 2'd2;
    assign memdotper[402 ] = 2'd2;
    assign memdotper[403 ] = 2'd2;
    assign memdotper[404 ] = 2'd1;
    assign memdotper[405 ] = 2'd0;
    assign memdotper[406 ] = 2'd0;
    assign memdotper[407 ] = 2'd2;
    assign memdotper[408 ] = 2'd2;
    assign memdotper[409 ] = 2'd2;
    assign memdotper[410 ] = 2'd2;
    assign memdotper[411 ] = 2'd2;
    assign memdotper[412 ] = 2'd0;
    assign memdotper[413 ] = 2'd0;
    assign memdotper[414 ] = 2'd0;
    assign memdotper[415 ] = 2'd0;
    assign memdotper[416 ] = 2'd0;
    assign memdotper[417 ] = 2'd0;
    assign memdotper[418 ] = 2'd0;
    assign memdotper[419 ] = 2'd0;
    assign memdotper[420 ] = 2'd0;
    assign memdotper[421 ] = 2'd0;
    assign memdotper[422 ] = 2'd0;
    assign memdotper[423 ] = 2'd0;
    assign memdotper[424 ] = 2'd0;
    assign memdotper[425 ] = 2'd0;
    assign memdotper[426 ] = 2'd0;
    assign memdotper[427 ] = 2'd0;
    assign memdotper[428 ] = 2'd0;
    assign memdotper[429 ] = 2'd0;
    assign memdotper[430 ] = 2'd0;
    assign memdotper[431 ] = 2'd0;
    assign memdotper[432 ] = 2'd0;
    assign memdotper[433 ] = 2'd2;
    assign memdotper[434 ] = 2'd2;
    assign memdotper[435 ] = 2'd1;
    assign memdotper[436 ] = 2'd1;
    assign memdotper[437 ] = 2'd0;
    assign memdotper[438 ] = 2'd2;
    assign memdotper[439 ] = 2'd2;
    assign memdotper[440 ] = 2'd2;
    assign memdotper[441 ] = 2'd2;
    assign memdotper[442 ] = 2'd2;
    assign memdotper[443 ] = 2'd2;
    assign memdotper[444 ] = 2'd2;
    assign memdotper[445 ] = 2'd0;
    assign memdotper[446 ] = 2'd0;
    assign memdotper[447 ] = 2'd0;
    assign memdotper[448 ] = 2'd0;
    assign memdotper[449 ] = 2'd0;
    assign memdotper[450 ] = 2'd0;
    assign memdotper[451 ] = 2'd0;
    assign memdotper[452 ] = 2'd0;
    assign memdotper[453 ] = 2'd0;
    assign memdotper[454 ] = 2'd0;
    assign memdotper[455 ] = 2'd0;
    assign memdotper[456 ] = 2'd0;
    assign memdotper[457 ] = 2'd0;
    assign memdotper[458 ] = 2'd0;
    assign memdotper[459 ] = 2'd0;
    assign memdotper[460 ] = 2'd0;
    assign memdotper[461 ] = 2'd0;
    assign memdotper[462 ] = 2'd0;
    assign memdotper[463 ] = 2'd0;
    assign memdotper[464 ] = 2'd2;
    assign memdotper[465 ] = 2'd2;
    assign memdotper[466 ] = 2'd1;
    assign memdotper[467 ] = 2'd1;
    assign memdotper[468 ] = 2'd0;
    assign memdotper[469 ] = 2'd2;
    assign memdotper[470 ] = 2'd2;
    assign memdotper[471 ] = 2'd2;
    assign memdotper[472 ] = 2'd1;
    assign memdotper[473 ] = 2'd1;
    assign memdotper[474 ] = 2'd1;
    assign memdotper[475 ] = 2'd2;
    assign memdotper[476 ] = 2'd2;
    assign memdotper[477 ] = 2'd2;
    assign memdotper[478 ] = 2'd0;
    assign memdotper[479 ] = 2'd0;
    assign memdotper[480 ] = 2'd0;
    assign memdotper[481 ] = 2'd0;
    assign memdotper[482 ] = 2'd0;
    assign memdotper[483 ] = 2'd0;
    assign memdotper[484 ] = 2'd0;
    assign memdotper[485 ] = 2'd0;
    assign memdotper[486 ] = 2'd0;
    assign memdotper[487 ] = 2'd0;
    assign memdotper[488 ] = 2'd0;
    assign memdotper[489 ] = 2'd0;
    assign memdotper[490 ] = 2'd0;
    assign memdotper[491 ] = 2'd0;
    assign memdotper[492 ] = 2'd0;
    assign memdotper[493 ] = 2'd0;
    assign memdotper[494 ] = 2'd0;
    assign memdotper[495 ] = 2'd2;
    assign memdotper[496 ] = 2'd2;
    assign memdotper[497 ] = 2'd2;
    assign memdotper[498 ] = 2'd1;
    assign memdotper[499 ] = 2'd0;
    assign memdotper[500 ] = 2'd2;
    assign memdotper[501 ] = 2'd2;
    assign memdotper[502 ] = 2'd2;
    assign memdotper[503 ] = 2'd1;
    assign memdotper[504 ] = 2'd1;
    assign memdotper[505 ] = 2'd0;
    assign memdotper[506 ] = 2'd0;
    assign memdotper[507 ] = 2'd0;
    assign memdotper[508 ] = 2'd2;
    assign memdotper[509 ] = 2'd2;
    assign memdotper[510 ] = 2'd2;
    assign memdotper[511 ] = 2'd0;
    assign memdotper[512 ] = 2'd0;
    assign memdotper[513 ] = 2'd0;
    assign memdotper[514 ] = 2'd0;
    assign memdotper[515 ] = 2'd0;
    assign memdotper[516 ] = 2'd0;
    assign memdotper[517 ] = 2'd0;
    assign memdotper[518 ] = 2'd0;
    assign memdotper[519 ] = 2'd0;
    assign memdotper[520 ] = 2'd0;
    assign memdotper[521 ] = 2'd0;
    assign memdotper[522 ] = 2'd0;
    assign memdotper[523 ] = 2'd0;
    assign memdotper[524 ] = 2'd0;
    assign memdotper[525 ] = 2'd0;
    assign memdotper[526 ] = 2'd0;
    assign memdotper[527 ] = 2'd2;
    assign memdotper[528 ] = 2'd2;
    assign memdotper[529 ] = 2'd1;
    assign memdotper[530 ] = 2'd1;
    assign memdotper[531 ] = 2'd0;
    assign memdotper[532 ] = 2'd2;
    assign memdotper[533 ] = 2'd2;
    assign memdotper[534 ] = 2'd1;
    assign memdotper[535 ] = 2'd1;
    assign memdotper[536 ] = 2'd0;
    assign memdotper[537 ] = 2'd0;
    assign memdotper[538 ] = 2'd0;
    assign memdotper[539 ] = 2'd0;
    assign memdotper[540 ] = 2'd0;
    assign memdotper[541 ] = 2'd2;
    assign memdotper[542 ] = 2'd2;
    assign memdotper[543 ] = 2'd1;
    assign memdotper[544 ] = 2'd0;
    assign memdotper[545 ] = 2'd0;
    assign memdotper[546 ] = 2'd0;
    assign memdotper[547 ] = 2'd0;
    assign memdotper[548 ] = 2'd0;
    assign memdotper[549 ] = 2'd0;
    assign memdotper[550 ] = 2'd0;
    assign memdotper[551 ] = 2'd0;
    assign memdotper[552 ] = 2'd0;
    assign memdotper[553 ] = 2'd0;
    assign memdotper[554 ] = 2'd0;
    assign memdotper[555 ] = 2'd0;
    assign memdotper[556 ] = 2'd0;
    assign memdotper[557 ] = 2'd0;
    assign memdotper[558 ] = 2'd2;
    assign memdotper[559 ] = 2'd2;
    assign memdotper[560 ] = 2'd1;
    assign memdotper[561 ] = 2'd1;
    assign memdotper[562 ] = 2'd0;
    assign memdotper[563 ] = 2'd0;
    assign memdotper[564 ] = 2'd2;
    assign memdotper[565 ] = 2'd2;
    assign memdotper[566 ] = 2'd1;
    assign memdotper[567 ] = 2'd0;
    assign memdotper[568 ] = 2'd0;
    assign memdotper[569 ] = 2'd0;
    assign memdotper[570 ] = 2'd0;
    assign memdotper[571 ] = 2'd0;
    assign memdotper[572 ] = 2'd0;
    assign memdotper[573 ] = 2'd2;
    assign memdotper[574 ] = 2'd2;
    assign memdotper[575 ] = 2'd1;
    assign memdotper[576 ] = 2'd0;
    assign memdotper[577 ] = 2'd0;
    assign memdotper[578 ] = 2'd0;
    assign memdotper[579 ] = 2'd0;
    assign memdotper[580 ] = 2'd0;
    assign memdotper[581 ] = 2'd0;
    assign memdotper[582 ] = 2'd0;
    assign memdotper[583 ] = 2'd0;
    assign memdotper[584 ] = 2'd0;
    assign memdotper[585 ] = 2'd0;
    assign memdotper[586 ] = 2'd0;
    assign memdotper[587 ] = 2'd0;
    assign memdotper[588 ] = 2'd0;
    assign memdotper[589 ] = 2'd2;
    assign memdotper[590 ] = 2'd2;
    assign memdotper[591 ] = 2'd2;
    assign memdotper[592 ] = 2'd1;
    assign memdotper[593 ] = 2'd0;
    assign memdotper[594 ] = 2'd0;
    assign memdotper[595 ] = 2'd0;
    assign memdotper[596 ] = 2'd2;
    assign memdotper[597 ] = 2'd2;
    assign memdotper[598 ] = 2'd1;
    assign memdotper[599 ] = 2'd0;
    assign memdotper[600 ] = 2'd0;
    assign memdotper[601 ] = 2'd0;
    assign memdotper[602 ] = 2'd0;
    assign memdotper[603 ] = 2'd0;
    assign memdotper[604 ] = 2'd0;
    assign memdotper[605 ] = 2'd2;
    assign memdotper[606 ] = 2'd2;
    assign memdotper[607 ] = 2'd1;
    assign memdotper[608 ] = 2'd0;
    assign memdotper[609 ] = 2'd0;
    assign memdotper[610 ] = 2'd2;
    assign memdotper[611 ] = 2'd2;
    assign memdotper[612 ] = 2'd0;
    assign memdotper[613 ] = 2'd0;
    assign memdotper[614 ] = 2'd0;
    assign memdotper[615 ] = 2'd0;
    assign memdotper[616 ] = 2'd0;
    assign memdotper[617 ] = 2'd0;
    assign memdotper[618 ] = 2'd0;
    assign memdotper[619 ] = 2'd0;
    assign memdotper[620 ] = 2'd0;
    assign memdotper[621 ] = 2'd2;
    assign memdotper[622 ] = 2'd2;
    assign memdotper[623 ] = 2'd1;
    assign memdotper[624 ] = 2'd1;
    assign memdotper[625 ] = 2'd0;
    assign memdotper[626 ] = 2'd0;
    assign memdotper[627 ] = 2'd0;
    assign memdotper[628 ] = 2'd2;
    assign memdotper[629 ] = 2'd2;
    assign memdotper[630 ] = 2'd2;
    assign memdotper[631 ] = 2'd0;
    assign memdotper[632 ] = 2'd0;
    assign memdotper[633 ] = 2'd0;
    assign memdotper[634 ] = 2'd0;
    assign memdotper[635 ] = 2'd0;
    assign memdotper[636 ] = 2'd2;
    assign memdotper[637 ] = 2'd2;
    assign memdotper[638 ] = 2'd2;
    assign memdotper[639 ] = 2'd1;
    assign memdotper[640 ] = 2'd0;
    assign memdotper[641 ] = 2'd2;
    assign memdotper[642 ] = 2'd2;
    assign memdotper[643 ] = 2'd2;
    assign memdotper[644 ] = 2'd2;
    assign memdotper[645 ] = 2'd0;
    assign memdotper[646 ] = 2'd0;
    assign memdotper[647 ] = 2'd0;
    assign memdotper[648 ] = 2'd0;
    assign memdotper[649 ] = 2'd0;
    assign memdotper[650 ] = 2'd0;
    assign memdotper[651 ] = 2'd0;
    assign memdotper[652 ] = 2'd2;
    assign memdotper[653 ] = 2'd2;
    assign memdotper[654 ] = 2'd1;
    assign memdotper[655 ] = 2'd1;
    assign memdotper[656 ] = 2'd0;
    assign memdotper[657 ] = 2'd0;
    assign memdotper[658 ] = 2'd0;
    assign memdotper[659 ] = 2'd0;
    assign memdotper[660 ] = 2'd0;
    assign memdotper[661 ] = 2'd2;
    assign memdotper[662 ] = 2'd2;
    assign memdotper[663 ] = 2'd2;
    assign memdotper[664 ] = 2'd0;
    assign memdotper[665 ] = 2'd0;
    assign memdotper[666 ] = 2'd0;
    assign memdotper[667 ] = 2'd2;
    assign memdotper[668 ] = 2'd2;
    assign memdotper[669 ] = 2'd2;
    assign memdotper[670 ] = 2'd1;
    assign memdotper[671 ] = 2'd1;
    assign memdotper[672 ] = 2'd0;
    assign memdotper[673 ] = 2'd2;
    assign memdotper[674 ] = 2'd2;
    assign memdotper[675 ] = 2'd2;
    assign memdotper[676 ] = 2'd2;
    assign memdotper[677 ] = 2'd1;
    assign memdotper[678 ] = 2'd0;
    assign memdotper[679 ] = 2'd0;
    assign memdotper[680 ] = 2'd0;
    assign memdotper[681 ] = 2'd0;
    assign memdotper[682 ] = 2'd0;
    assign memdotper[683 ] = 2'd2;
    assign memdotper[684 ] = 2'd2;
    assign memdotper[685 ] = 2'd2;
    assign memdotper[686 ] = 2'd1;
    assign memdotper[687 ] = 2'd0;
    assign memdotper[688 ] = 2'd0;
    assign memdotper[689 ] = 2'd0;
    assign memdotper[690 ] = 2'd0;
    assign memdotper[691 ] = 2'd0;
    assign memdotper[692 ] = 2'd0;
    assign memdotper[693 ] = 2'd0;
    assign memdotper[694 ] = 2'd2;
    assign memdotper[695 ] = 2'd2;
    assign memdotper[696 ] = 2'd2;
    assign memdotper[697 ] = 2'd2;
    assign memdotper[698 ] = 2'd2;
    assign memdotper[699 ] = 2'd2;
    assign memdotper[700 ] = 2'd2;
    assign memdotper[701 ] = 2'd1;
    assign memdotper[702 ] = 2'd1;
    assign memdotper[703 ] = 2'd0;
    assign memdotper[704 ] = 2'd0;
    assign memdotper[705 ] = 2'd0;
    assign memdotper[706 ] = 2'd2;
    assign memdotper[707 ] = 2'd2;
    assign memdotper[708 ] = 2'd1;
    assign memdotper[709 ] = 2'd1;
    assign memdotper[710 ] = 2'd0;
    assign memdotper[711 ] = 2'd0;
    assign memdotper[712 ] = 2'd0;
    assign memdotper[713 ] = 2'd0;
    assign memdotper[714 ] = 2'd0;
    assign memdotper[715 ] = 2'd2;
    assign memdotper[716 ] = 2'd2;
    assign memdotper[717 ] = 2'd1;
    assign memdotper[718 ] = 2'd1;
    assign memdotper[719 ] = 2'd0;
    assign memdotper[720 ] = 2'd0;
    assign memdotper[721 ] = 2'd0;
    assign memdotper[722 ] = 2'd0;
    assign memdotper[723 ] = 2'd0;
    assign memdotper[724 ] = 2'd0;
    assign memdotper[725 ] = 2'd0;
    assign memdotper[726 ] = 2'd0;
    assign memdotper[727 ] = 2'd2;
    assign memdotper[728 ] = 2'd2;
    assign memdotper[729 ] = 2'd2;
    assign memdotper[730 ] = 2'd2;
    assign memdotper[731 ] = 2'd2;
    assign memdotper[732 ] = 2'd1;
    assign memdotper[733 ] = 2'd1;
    assign memdotper[734 ] = 2'd0;
    assign memdotper[735 ] = 2'd0;
    assign memdotper[736 ] = 2'd0;
    assign memdotper[737 ] = 2'd0;
    assign memdotper[738 ] = 2'd0;
    assign memdotper[739 ] = 2'd1;
    assign memdotper[740 ] = 2'd1;
    assign memdotper[741 ] = 2'd0;
    assign memdotper[742 ] = 2'd0;
    assign memdotper[743 ] = 2'd0;
    assign memdotper[744 ] = 2'd0;
    assign memdotper[745 ] = 2'd0;
    assign memdotper[746 ] = 2'd2;
    assign memdotper[747 ] = 2'd2;
    assign memdotper[748 ] = 2'd1;
    assign memdotper[749 ] = 2'd1;
    assign memdotper[750 ] = 2'd0;
    assign memdotper[751 ] = 2'd0;
    assign memdotper[752 ] = 2'd0;
    assign memdotper[753 ] = 2'd0;
    assign memdotper[754 ] = 2'd0;
    assign memdotper[755 ] = 2'd0;
    assign memdotper[756 ] = 2'd0;
    assign memdotper[757 ] = 2'd0;
    assign memdotper[758 ] = 2'd0;
    assign memdotper[759 ] = 2'd0;
    assign memdotper[760 ] = 2'd1;
    assign memdotper[761 ] = 2'd1;
    assign memdotper[762 ] = 2'd1;
    assign memdotper[763 ] = 2'd1;
    assign memdotper[764 ] = 2'd1;
    assign memdotper[765 ] = 2'd0;
    assign memdotper[766 ] = 2'd0;
    assign memdotper[767 ] = 2'd0;

endmodule
