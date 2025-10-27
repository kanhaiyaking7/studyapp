
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hi/features/auth/pages/Username.dart';
// import 'package:hi/features/universal/internetstream.dart';
// import 'package:hi/pages/Navbar.dart';
//
// class Checkinternet extends ConsumerWidget {
//   const Checkinternet({super.key});
//
//   @override
//   Widget build(BuildContext context, ref) {
//     final inter = ref.watch(internetstrem);
//
//     return
//       inter.when(
//           data: (check){
//             print(check);
//             if(check == networkstatus.offline){
//               return Center(
//                 child: Text("no internet"),
//               );
//             }else{
//               return BottomNav();
//             }
//
//
//           },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (e, _) => Center(child: Text('Error: $e'))
//       );
//   }
// }
