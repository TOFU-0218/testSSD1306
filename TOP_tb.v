`timescale 1ns/1ps

module i2c_emulator_tb;

reg clk_tb;
reg reset_n_tb;
reg button_scl_tb;
reg button_sda_tb;
wire scl_tb;
wire sda_tb;

// テストベンチのインスタンス化
i2c_emulator i2c_emulator_tb_inst(
    .clk(clk_tb),
    .reset_n(reset_n_tb),
    .button_scl(button_scl_tb),
    .button_sda(button_sda_tb),
    .scl(scl_tb),
    .sda(sda_tb)
);

// クロック信号の生成
initial begin 
    $dumpfile("wave.vcd");
    $dumpvars(0, i2c_emulator_tb_inst);
    clk_tb = 1'b0;
    forever #10 clk_tb = ~clk_tb; // 50Mhzのクロックを生成(周期20ns)
end

// テストシナリオ
initial begin
    // 初期化
    reset_n_tb = 1'b0; // リセット
    button_scl_tb = 1'b0; 
    button_sda_tb = 1'b0;
    #100;

    reset_n_tb = 1'b1; // リセット解除
    #100;

    // SCLボタンを押すシミュレーション
    button_scl_tb = 1'b1; #20;
    button_scl_tb = 1'b0; #20;

    // SDAボタンを押すシミュレーション
    button_sda_tb = 1'b1; #20;
    button_sda_tb = 1'b0; #20;

    // さらにボタン操作をシミュレート
    #100;
    button_scl_tb = 1'b1; #20;
    button_scl_tb = 1'b0; #40;
    button_sda_tb = 1'b1; #20;
    button_sda_tb = 1'b0; #20;

    // シミュレーション終了
    #100;
    $finish;
end
endmodule