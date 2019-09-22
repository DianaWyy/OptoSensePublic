'use strict'
const noble = require('noble-mac')
const TARGET_LOCAL_NAME = 'optoSense'
const net = require('net')
const client = new net.Socket()
var ready_to_write = false

client.connect(2337, '127.0.0.1', () => {
  console.log('Connected')
  ready_to_write = true
  //!!!!!!!!!!!!!!!For testing only! comment this out!!!!!!!!!
  // setInterval(() => {
  //   client.write('test')
  // }, 1000)
})

noble.on('stateChange', function(state) {
  if (state === 'poweredOn') {
    noble.startScanning();
    console.log('poweredOn')
  } else {
    noble.stopScanning();
  }
});

noble.on('discover', function(peripheral) {
  console.log(`peripheral discovered ( ${peripheral.id} with addr <${peripheral.address}, ${peripheral.addressType}> connectable ${peripheral.connectable} RSSI: ${peripheral.rssi} local name: ${peripheral.advertisement.localName})`)
  if (peripheral.advertisement.localName === TARGET_LOCAL_NAME){
    console.log('Found target!')
    noble.stopScanning();
    peripheral.connect(function(error) {
      peripheral.discoverServices([], (err, services) => {
        if (err) {
          console.log(err)
        }
        if (services[0].uuid === '6e400001b5a3f393e0a9e50e24dcca9e'){
          services[0].discoverCharacteristics([], function(error, characteristics) {
            if (characteristics[1].uuid === '6e400003b5a3f393e0a9e50e24dcca9e'){              
              console.log("found characteristics")
              characteristics[1].notify(true, function(error) {
                console.log('notification on');
              })
              characteristics[1].on('data', (data, isNotification) => {
                var uint8array = Uint8Array.from(data)
                // console.log(data.length)
                // console.log(uint8array.length)
				// var pixel0 = uint8array[0] * 256 + uint8array[1] 
				// var pixel1 = uint8array[2] * 256 + uint8array[3] 
				// var pixel2 = uint8array[4] * 256 + uint8array[5] 
				// var pixel3 = uint8array[6] * 256 + uint8array[7] 
				// var pixel4 = uint8array[8] * 256 + uint8array[9] 
				// var pixel5 = uint8array[10] * 256 + uint8array[11] 
				// var pixel6 = uint8array[12] * 256 + uint8array[13] 
				// var pixel7 = uint8array[14] * 256 + uint8array[15] 

				// var pixel8 = uint8array[16] * 256 + uint8array[17] 
				// var pixel9 = uint8array[18] * 256 + uint8array[19] 
				// var pixel10 = uint8array[20] * 256 + uint8array[21] 
				// var pixel11 = uint8array[22] * 256 + uint8array[23] 
				// var pixel12 = uint8array[24] * 256 + uint8array[25] 
				// var pixel13 = uint8array[26] * 256 + uint8array[27] 
				// var pixel14 = uint8array[28] * 256 + uint8array[29] 
				// var pixel15 = uint8array[30] * 256 + uint8array[31] 

				// var pixel16 = uint8array[32] * 256 + uint8array[33] 
				// var pixel17 = uint8array[34] * 256 + uint8array[35] 
				// var pixel18 = uint8array[36] * 256 + uint8array[37] 
				// var pixel19 = uint8array[38] * 256 + uint8array[39] 
				// var pixel20 = uint8array[40] * 256 + uint8array[41] 
				// var pixel21 = uint8array[42] * 256 + uint8array[43] 
				// var pixel22 = uint8array[44] * 256 + uint8array[45] 
				// var pixel23 = uint8array[46] * 256 + uint8array[47] 

				// var pixel24 = uint8array[48] * 256 + uint8array[49] 
				// var pixel25 = uint8array[50] * 256 + uint8array[51] 
				// var pixel26 = uint8array[52] * 256 + uint8array[53] 
				// var pixel27 = uint8array[54] * 256 + uint8array[55] 
				// var pixel28 = uint8array[56] * 256 + uint8array[57] 
				// var pixel29 = uint8array[58] * 256 + uint8array[59] 
				// var pixel30 = uint8array[60] * 256 + uint8array[61] 
				// var pixel31 = uint8array[62] * 256 + uint8array[63] 

				// var pixel32 = uint8array[64] * 256 + uint8array[65] 
				// var pixel33 = uint8array[66] * 256 + uint8array[67] 
				// var pixel34 = uint8array[68] * 256 + uint8array[69] 
				// var pixel35 = uint8array[70] * 256 + uint8array[71] 
				// var pixel36 = uint8array[72] * 256 + uint8array[73] 
				// var pixel37 = uint8array[74] * 256 + uint8array[75] 
				// var pixel38 = uint8array[76] * 256 + uint8array[77] 
				// var pixel39 = uint8array[78] * 256 + uint8array[79] 

				// var pixel40 = uint8array[80] * 256 + uint8array[81] 
				// var pixel41 = uint8array[82] * 256 + uint8array[83] 
				// var pixel42 = uint8array[84] * 256 + uint8array[85] 
				// var pixel43 = uint8array[86] * 256 + uint8array[87] 
				// var pixel44 = uint8array[88] * 256 + uint8array[89] 
				// var pixel45 = uint8array[90] * 256 + uint8array[91] 
				// var pixel46 = uint8array[92] * 256 + uint8array[93] 
				// var pixel47 = uint8array[94] * 256 + uint8array[95] 

				// var pixel48 = uint8array[96] * 256 + uint8array[97] 
				// var pixel49 = uint8array[98] * 256 + uint8array[99] 
				// var pixel50 = uint8array[100] * 256 + uint8array[101] 
				// var pixel51 = uint8array[102] * 256 + uint8array[103] 
				// var pixel52 = uint8array[104] * 256 + uint8array[105] 
				// var pixel53 = uint8array[106] * 256 + uint8array[107] 
				// var pixel54 = uint8array[108] * 256 + uint8array[109] 
				// var pixel55 = uint8array[110] * 256 + uint8array[111] 

				// var pixel56 = uint8array[112] * 256 + uint8array[113] 
				// var pixel57 = uint8array[114] * 256 + uint8array[115] 
				// var pixel58 = uint8array[116] * 256 + uint8array[117] 
				// var pixel59 = uint8array[118] * 256 + uint8array[119] 
				// var pixel60 = uint8array[120] * 256 + uint8array[121] 
				// var pixel61 = uint8array[122] * 256 + uint8array[123] 
				// var pixel62 = uint8array[124] * 256 + uint8array[125] 
				// var pixel63 = uint8array[126] * 256 + uint8array[127] 

                if (ready_to_write) {
                  client.write(uint8array[0] + ' '
                    + uint8array[1] + ' '
                    + uint8array[2] + ' '
                    + uint8array[3] + ' '
                    + uint8array[4] + ' '
                    + uint8array[5] + ' '
                    + uint8array[6] + ' '
                    + uint8array[7] + ' '
                    + uint8array[8] + ' '
                    + uint8array[9] + ' '
                    + uint8array[10] + ' '
                    + uint8array[11] + ' '
                    + uint8array[12] + ' '
                    + uint8array[13] + ' '
                    + uint8array[14] + ' '
                    + uint8array[15] + ' '
                    + uint8array[16] + ' '
                    + uint8array[17] + ' '
                    + uint8array[18] + ' '
                    + uint8array[19] + ' '
                    + uint8array[20] + ' '
                    + uint8array[21] + ' '
                    + uint8array[22] + ' '
                    + uint8array[23] + ' '
                    + uint8array[24] + ' '
                    + uint8array[25] + ' '
                    + uint8array[26] + ' '
                    + uint8array[27] + ' '
                    + uint8array[28] + ' '
                    + uint8array[29] + ' '
                    + uint8array[30] + ' '
                    + uint8array[31] + ' '
                    + uint8array[32] + ' '
                    + uint8array[33] + ' '
                    + uint8array[34] + ' '
                    + uint8array[35] + ' '
                    + uint8array[36] + ' '
                    + uint8array[37] + ' '
                    + uint8array[38] + ' '
                    + uint8array[39] + ' '
                    + uint8array[40] + ' '
                    + uint8array[41] + ' '
                    + uint8array[42] + ' '
                    + uint8array[43] + ' '
                    + uint8array[44] + ' '
                    + uint8array[45] + ' '
                    + uint8array[46] + ' '
                    + uint8array[47] + ' '
                    + uint8array[48] + ' '
                    + uint8array[49] + ' '
                    + uint8array[50] + ' '
                    + uint8array[51] + ' '
                    + uint8array[52] + ' '
                    + uint8array[53] + ' '
                    + uint8array[54] + ' '
                    + uint8array[55] + ' '
                    + uint8array[56] + ' '
                    + uint8array[57] + ' '
                    + uint8array[58] + ' '
                    + uint8array[59] + ' '
                    + uint8array[60] + ' '
                    + uint8array[61] + ' '
                    + uint8array[62] + ' '
                    + uint8array[63])
					// client.write(pixel0 + ' '
					// 	+ pixel1 + ' '
					// 	+ pixel2 + ' '
					// 	+ pixel3 + ' '
					// 	+ pixel4 + ' '
					// 	+ pixel5 + ' '
					// 	+ pixel6 + ' '
					// 	+ pixel7 + ' '
					// 	+ pixel8 + ' '
					// 	+ pixel9 + ' '
					// 	+ pixel10 + ' '
					// 	+ pixel11 + ' '
					// 	+ pixel12 + ' '
					// 	+ pixel13 + ' '
					// 	+ pixel14 + ' '
					// 	+ pixel15 + ' '
					// 	+ pixel16 + ' '
					// 	+ pixel17 + ' '
					// 	+ pixel18 + ' '
					// 	+ pixel19 + ' '
					// 	+ pixel20 + ' '
					// 	+ pixel21 + ' '
					// 	+ pixel22 + ' '
					// 	+ pixel23 + ' '
					// 	+ pixel24 + ' '
					// 	+ pixel25 + ' '
					// 	+ pixel26 + ' '
					// 	+ pixel27 + ' '
					// 	+ pixel28 + ' '
					// 	+ pixel29 + ' '
					// 	+ pixel30 + ' '
					// 	+ pixel31 + ' '
					// 	+ pixel32 + ' '
					// 	+ pixel33 + ' '
					// 	+ pixel34 + ' '
					// 	+ pixel35 + ' '
					// 	+ pixel36 + ' '
					// 	+ pixel37 + ' '
					// 	+ pixel38 + ' '
					// 	+ pixel39 + ' '
					// 	+ pixel40 + ' '
					// 	+ pixel41 + ' '
					// 	+ pixel42 + ' '
					// 	+ pixel43 + ' '
					// 	+ pixel44 + ' '
					// 	+ pixel45 + ' '
					// 	+ pixel46 + ' '
					// 	+ pixel47 + ' '
					// 	+ pixel48 + ' '
					// 	+ pixel49 + ' '
					// 	+ pixel50 + ' '
					// 	+ pixel51 + ' '
					// 	+ pixel52 + ' '
					// 	+ pixel53 + ' '
					// 	+ pixel54 + ' '
					// 	+ pixel55 + ' '
					// 	+ pixel56 + ' '
					// 	+ pixel57 + ' '
					// 	+ pixel58 + ' '
					// 	+ pixel59 + ' '
					// 	+ pixel60 + ' '
					// 	+ pixel61 + ' '
					// 	+ pixel62 + ' '
					// 	+ pixel63)
                }                // var float32Array = Float32Array.from(data)
                // console.log(float32Array)
                // if (ready_to_write) {
                //   client.write(float32Array[0] + ' '
                //     + float32Array[1] + ' '
                //     + float32Array[2] + ' '
                //     + float32Array[3] + ' '
                //     + float32Array[4] + ' '
                //     + float32Array[5] + ' '
                //     + float32Array[6] + ' '
                //     + float32Array[7] + ' '
                //     + float32Array[8] + ' '
                //     + float32Array[9] + ' '
                //     + float32Array[10] + ' '
                //     + float32Array[11] + ' '
                //     + float32Array[12] + ' '
                //     + float32Array[13] + ' '
                //     + float32Array[14] + ' '
                //     + float32Array[15] + ' '
                //     + float32Array[16] + ' '
                //     + float32Array[17] + ' '
                //     + float32Array[18] + ' '
                //     + float32Array[19] + ' '
                //     + float32Array[20] + ' '
                //     + float32Array[21] + ' '
                //     + float32Array[22] + ' '
                //     + float32Array[23] + ' '
                //     + float32Array[24] + ' '
                //     + float32Array[25] + ' '
                //     + float32Array[26] + ' '
                //     + float32Array[27] + ' '
                //     + float32Array[28] + ' '
                //     + float32Array[29] + ' '
                //     + float32Array[30] + ' '
                //     + float32Array[31] + ' '
                //     + float32Array[32] + ' '
                //     + float32Array[33] + ' '
                //     + float32Array[34] + ' '
                //     + float32Array[35] + ' '
                //     + float32Array[36] + ' '
                //     + float32Array[37] + ' '
                //     + float32Array[38] + ' '
                //     + float32Array[39] + ' '
                //     + float32Array[40] + ' '
                //     + float32Array[41] + ' '
                //     + float32Array[42] + ' '
                //     + float32Array[43] + ' '
                //     + float32Array[44] + ' '
                //     + float32Array[45] + ' '
                //     + float32Array[46] + ' '
                //     + float32Array[47] + ' '
                //     + float32Array[48] + ' '
                //     + float32Array[49] + ' '
                //     + float32Array[50] + ' '
                //     + float32Array[51] + ' '
                //     + float32Array[52] + ' '
                //     + float32Array[53] + ' '
                //     + float32Array[54] + ' '
                //     + float32Array[55] + ' '
                //     + float32Array[56] + ' '
                //     + float32Array[57] + ' '
                //     + float32Array[58] + ' '
                //     + float32Array[59] + ' '
                //     + float32Array[60] + ' '
                //     + float32Array[61] + ' '
                //     + float32Array[62] + ' '
                //     + float32Array[63])
                // }
              });    
            }
          });
        }
      });
    });
  }
});
