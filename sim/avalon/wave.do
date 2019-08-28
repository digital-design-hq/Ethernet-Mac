onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/clk
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reset
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_read
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_write
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_address
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_data_in
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_read_valid
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_data_out
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/irq
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/mdc
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/mdio
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_adapter_io/clk
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_adapter_io/reset
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_adapter_io/data_in
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_adapter_io/data_out
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_adapter_io/write_en
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_adapter_io/read_en
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_io/clk
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_io/reset
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_io/transmit_data_in
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_io/receive_data
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_io/receive_valid
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_io/transmit_ready
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_io/busy
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_io/transmit_we
add wave -noupdate -expand -group avalon_ethernet_mac /avalon_ethernet_mdio_tb/dut/reg_io/receive_re
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/clk
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/reset
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/read
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/write
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/address
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/data_in
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/read_valid
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/data_out
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/read_reg
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/write_reg
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/address_reg
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/data_in_reg
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/data_out_reg
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/read_reg_next
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/write_reg_next
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/address_reg_next
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/data_in_reg_next
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/data_out_reg_next
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/read_en
add wave -noupdate -expand -group avalon_register_adapter /avalon_ethernet_mdio_tb/dut/avalon_register_adapter/write_en
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/reg_io/clk
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/reg_io/reset
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/reg_io/transmit_data_in
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/reg_io/receive_data
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/reg_io/receive_valid
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/reg_io/transmit_ready
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/reg_io/busy
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/reg_io/transmit_we
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/reg_io/receive_re
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/mdc
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/mdio
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/clk_en
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/transmit_ready
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/receive_valid
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/receive_data
add wave -noupdate -expand -group mdio_core /avalon_ethernet_mdio_tb/dut/mdio_core/transmit_data
add wave -noupdate -expand -group mdio_clock_en /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_clock_en/clk
add wave -noupdate -expand -group mdio_clock_en /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_clock_en/reset
add wave -noupdate -expand -group mdio_clock_en /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_clock_en/clk_en
add wave -noupdate -expand -group mdio_clock_en /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_clock_en/cycle_counter
add wave -noupdate -expand -group mdio_clock_en /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_clock_en/cycle_counter_next
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/clk
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/reset
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/transmit_data
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/receive_data
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/clk_en
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/transmit_valid
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/transmit_ready
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/receive_valid
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/busy
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/mdc
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/mdio
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/state
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/bit_count
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/idle_count
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/upper_data_reg
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/lower_data_reg
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/opcode_reg
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/transmit_ready_reg
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/receive_valid_reg
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/mdio_out_reg
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/mdio_out_en_reg
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/state_next
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/bit_count_next
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/idle_count_next
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/upper_data_reg_next
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/lower_data_reg_next
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/opcode_reg_next
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/transmit_ready_reg_next
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/receive_valid_reg_next
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/mdc_next
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/mdio_in
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/mdio_out_reg_next
add wave -noupdate -expand -group mdio_controller /avalon_ethernet_mdio_tb/dut/mdio_core/mdio_controller/mdio_out_en_reg_next
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {169500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 585
configure wave -valuecolwidth 217
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {8500 ps} {333500 ps}
