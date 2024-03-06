// ボタンを押してSCLとSDA信号を生成するモジュール

module i2c_emulator(
    input clk, // クロック
    input reset_n, // 非同期リセット不論理
    input button_scl, // SCL信号を生成するためのボタン入力
    input button_sda, // SDA信号を生成するためのボタン入力
    output reg scl, // SCL信号
    output reg sda // SDA信号
    );

    // ボタンの状態を保持するレジスタ
    reg button_scl_prev;
    reg button_sda_prev;

    // クロックエッジでのボタン状態の更新とSCL、SDA信号の生成
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n) begin
            scl <= 1'b1; // I2Cはアイドル時にHigh
            sda <= 1'b1; // I2Cはアイドル時にHigh
            button_scl_prev <= 1'b0;
            button_sda_prev <= 1'b0;
        end else begin
            // 前の状態と比較して変化があった場合に信号をトグル
            if (button_scl != button_scl_prev) begin
                scl <= ~scl;
            end
            if (button_sda != button_sda_prev) begin
                sda <= ~sda;
            end
        
            // ボタンの状態を更新
            button_scl_prev <= button_scl;
            button_sda_prev <= button_sda;
        end
    end
endmodule