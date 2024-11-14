 #devnet 
 export PKG_ID=0xc5f4913ec48a3940203484610156a7d792e983c2dbda06077e87ab12b2b46502
 export FOO_ID=0xdc47058aabff2564afe1e988398703f065e4529fe9455b7d655fa54b5408d749

 export C_ADDR=0x540105a7d2f5f54a812c630f2996f1790ed0e60d1f9a870ce397f03e4cec9b38
 export W_ADDR=0xafe36044ef56d22494bfe6231e78dd128f097693f2d974761ee4d649e61f5fa2

# transfer 
sui client call --package $PKG_ID --module state_change --function do_transfer --args $FOO_ID  $W_ADDR

# mint_and_transfer to c_addr
sui client call --package $PKG_ID --module state_change --function mint_and_transfer --args $C_ADDR

export FOO3_ID=0x442e52426fa407994e29bd9c5c3023e23e01fbfb6cc897137c8c2980e9a2b48f
sui client call --package $PKG_ID --module state_change --function do_share --args $FOO3_ID

sui client call --package $PKG_ID --module state_change --function destroy --args $FOO_ID

