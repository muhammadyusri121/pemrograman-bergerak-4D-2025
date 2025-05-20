// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// // void main() {
// //   runApp(const MaterialApp(
// //     home: DetailPage(),
// //     debugShowCheckedModeBanner: false,
// //   ));
// // }

// class DetailPage extends StatelessWidget {
//   final int wisataId;
//   final dynamic
//       wisata; // Replace 'dynamic' with the actual type of 'wisata' if known.

//   const DetailPage({Key? key, required this.wisataId, this.wisata})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Custom AppBar
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () {
//                       Navigator.pop(
//                           context); // navigator pop adalah untuk kembali ke halaman sebelumnya
//                     },
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'National Park Yosemite',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.poppins(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 48),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Image
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.asset(
//                   'assets/images/gambar.png',
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Deskripsi
//               Text(
//                 'Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.',
//                 style: GoogleFonts.poppins(
//                   fontSize: 13,
//                   color: Colors.black87,
//                   height: 1.5,
//                 ),
//                 textAlign: TextAlign.justify,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class DetailPage extends StatelessWidget {
  final int wisataId;
  final dynamic wisata;

  const DetailPage({super.key, required this.wisataId, this.wisata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom AppBar
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      wisata.nama, // Gunakan nama dari wisata
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 16),

              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: wisata.imagePath.isNotEmpty
                    ? Image.file(
                        File(wisata.imagePath),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200, // Tambahkan tinggi agar konsisten
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/gambar.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      )
                    : Image.asset(
                        'assets/images/gambar.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
              ),
              const SizedBox(height: 16),

              // Deskripsi
              Text(
                wisata.deskripsi, // Gunakan deskripsi dari wisata
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
