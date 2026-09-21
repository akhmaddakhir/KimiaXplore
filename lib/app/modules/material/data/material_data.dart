import '../models/material_model.dart';

abstract final class MaterialData {
  static const List<MaterialModel> items = [
    MaterialModel(
      topicId: 'atomic_structure',
      sections: [
        MaterialSection(
          title: 'Apa Itu Atom?',
          paragraphs: [
            'Pernah kepikiran nggak, sebenarnya benda-benda di sekitar kita tersusun dari apa? Mulai dari air yang kamu minum, udara yang kamu hirup, sampai layar HP yang sedang kamu lihat, semuanya tersusun dari atom.',

            'Atom adalah bagian terkecil dari suatu unsur yang masih memiliki sifat kimia unsur tersebut. Ukurannya sangat kecil, sampai-sampai kita nggak bisa melihat atom satu per satu hanya dengan mata telanjang.',

            'Kata atom berasal dari bahasa Yunani "atomos" yang berarti tidak dapat dibagi. Dulu, atom dianggap sebagai bagian paling kecil dari materi. Namun, setelah ilmu pengetahuan berkembang, para ilmuwan menemukan bahwa atom ternyata masih tersusun dari partikel-partikel yang lebih kecil.',
          ],
        ),

        MaterialSection(
          title: 'Kenalan dengan Partikel Penyusun Atom',
          paragraphs: [
            'Walaupun ukurannya sangat kecil, atom punya struktur yang cukup menarik. Di dalamnya ada tiga partikel utama, yaitu proton, neutron, dan elektron.',

            'Ketiga partikel ini punya muatan, posisi, dan peran yang berbeda. Yuk, kenalan satu per satu!',

            '1. Proton\nProton adalah partikel bermuatan positif yang berada di dalam inti atom. Jumlah proton menentukan jenis suatu unsur. Misalnya, semua atom karbon punya 6 proton. Kalau jumlah protonnya berubah, unsur tersebut juga berubah.',

            '2. Neutron\nNeutron adalah partikel yang tidak memiliki muatan listrik. Partikel ini berada bersama proton di dalam inti atom. Neutron membantu menjaga kestabilan inti, meskipun jumlah neutron yang terlalu sedikit atau terlalu banyak juga bisa membuat inti menjadi tidak stabil.',

            '3. Elektron\nElektron adalah partikel bermuatan negatif yang berada di sekitar inti atom. Dalam model atom modern, elektron menempati daerah yang disebut orbital. Elektron, terutama elektron valensi, punya peran penting dalam menentukan bagaimana suatu atom berinteraksi dan membentuk ikatan kimia.',
          ],
        ),

        MaterialSection(
          title: 'Seperti Apa Struktur Atom?',
          paragraphs: [
            'Bayangin atom punya bagian pusat yang disebut inti atom atau nukleus. Di dalam inti inilah proton dan neutron berada, sedangkan elektron menempati daerah di sekitarnya.',

            'Ukuran inti atom sebenarnya sangat kecil dibandingkan ukuran atom secara keseluruhan. Namun, hampir seluruh massa atom justru terkumpul di bagian inti.',

            'Kenapa bisa begitu? Karena proton dan neutron memiliki massa yang jauh lebih besar dibandingkan elektron. Jadi, walaupun elektron ikut menyusun atom, kontribusinya terhadap massa atom sangat kecil.',
          ],
        ),

        MaterialSection(
          title: 'Nomor Atom dan Nomor Massa',
          paragraphs: [
            'Setiap unsur punya identitas yang membedakannya dari unsur lain. Salah satu cara mengenali identitas tersebut adalah dengan melihat nomor atomnya.',

            'Nomor atom menunjukkan jumlah proton yang ada di dalam inti suatu atom. Misalnya, hidrogen memiliki nomor atom 1 karena memiliki satu proton, sedangkan oksigen memiliki nomor atom 8 karena memiliki delapan proton.',

            'Kalau suatu atom bersifat netral, jumlah proton dan elektronnya sama. Jadi, atom oksigen yang netral memiliki 8 proton dan 8 elektron.',

            'Selain nomor atom, ada juga nomor massa. Nomor massa adalah jumlah total proton dan neutron di dalam inti atom.',

            'Cara mencari jumlah neutron cukup sederhana: kurangi nomor massa dengan nomor atom. Misalnya, atom karbon memiliki nomor atom 6 dan nomor massa 12. Artinya, atom tersebut memiliki 6 proton dan 6 neutron.',
          ],
        ),

        MaterialSection(
          title: 'Apa Itu Ion?',
          paragraphs: [
            'Atom nggak selalu memiliki jumlah elektron yang sama. Dalam kondisi tertentu, atom bisa kehilangan atau menerima elektron ketika berinteraksi dengan atom lain.',

            'Ketika jumlah elektron dan protonnya tidak lagi sama, atom akan memiliki muatan listrik. Atom atau kelompok atom yang memiliki muatan listrik inilah yang disebut ion.',

            'Kalau atom kehilangan elektron, jumlah protonnya menjadi lebih banyak daripada elektronnya. Akibatnya, atom memiliki muatan positif dan disebut kation.',

            'Sebaliknya, kalau atom menerima elektron, jumlah elektronnya menjadi lebih banyak daripada protonnya. Atom pun memiliki muatan negatif dan disebut anion.',

            'Contohnya, atom natrium (Na) dapat kehilangan satu elektron dan berubah menjadi ion Na⁺. Sementara itu, atom klorin (Cl) dapat menerima satu elektron dan berubah menjadi ion Cl⁻.',
          ],
        ),

        MaterialSection(
          title: 'Apa Itu Isotop?',
          paragraphs: [
            'Ternyata, atom dari unsur yang sama nggak selalu memiliki jumlah neutron yang sama. Atom-atom seperti ini disebut isotop.',

            'Isotop adalah atom-atom dari unsur yang sama yang memiliki jumlah proton sama, tetapi jumlah neutron berbeda.',

            'Contohnya, karbon-12 dan karbon-14 sama-sama memiliki 6 proton. Bedanya, karbon-12 memiliki 6 neutron, sedangkan karbon-14 memiliki 8 neutron.',

            'Karena jumlah protonnya sama, keduanya tetap termasuk unsur karbon. Namun, perbedaan jumlah neutron membuat nomor massa keduanya berbeda.',
          ],
        ),

        MaterialSection(
          title: 'Kesimpulan',
          paragraphs: [
            'Sekarang kamu sudah tahu bahwa atom bukan sekadar partikel kecil yang menyusun materi. Di dalam atom terdapat proton, neutron, dan elektron yang masing-masing punya peran berbeda.',

            'Proton menentukan identitas suatu unsur, neutron ikut memengaruhi massa dan kestabilan inti, sedangkan elektron berperan penting dalam interaksi dan pembentukan ikatan kimia.',

            'Dengan memahami struktur atom, kamu punya bekal untuk mempelajari topik kimia lainnya, mulai dari sistem periodik unsur sampai ikatan kimia.',
          ],
        ),
      ],
    ),

    MaterialModel(
      topicId: 'periodic_table',
      sections: [
        MaterialSection(
          title: 'Apa Itu Sistem Periodik Unsur?',
          paragraphs: [
            'Pernah lihat tabel besar yang berisi simbol-simbol seperti H, O, Fe, dan Au? Itu adalah tabel periodik unsur, salah satu alat penting yang sering digunakan dalam pelajaran kimia.',

            'Tabel periodik adalah susunan unsur-unsur kimia berdasarkan kenaikan nomor atom dan pola sifatnya. Dengan tabel ini, kita bisa melihat hubungan antara berbagai unsur tanpa harus menghafal semuanya satu per satu.',

            'Setiap unsur punya tempat tersendiri di dalam tabel. Posisi tersebut bukan ditentukan secara asal, melainkan berdasarkan struktur atom dan sifat unsur yang memiliki pola tertentu.',
          ],
        ),

        MaterialSection(
          title: 'Cara Membaca Tabel Periodik',
          paragraphs: [
            'Saat pertama kali melihat tabel periodik, kamu mungkin merasa tabelnya cukup rumit karena dipenuhi angka, simbol, dan warna yang berbeda.',

            'Sebenarnya, informasi dalam setiap kotak unsur bisa dipahami secara bertahap. Biasanya, sebuah kotak menampilkan nomor atom, simbol unsur, nama unsur, dan massa atom relatif.',

            'Contohnya, unsur oksigen memiliki simbol O dan nomor atom 8. Artinya, setiap atom oksigen memiliki 8 proton di dalam intinya.',

            'Kalau kamu sudah memahami informasi dasar ini, membaca tabel periodik akan terasa jauh lebih mudah.',
          ],
        ),

        MaterialSection(
          title: 'Apa Itu Periode?',
          paragraphs: [
            'Coba perhatikan baris mendatar pada tabel periodik. Baris-baris tersebut disebut periode.',

            'Tabel periodik memiliki tujuh periode. Nomor periode berkaitan dengan tingkat energi utama tertinggi yang ditempati elektron pada atom unsur tersebut dalam keadaan dasarnya.',

            'Dalam model kulit elektron sederhana, unsur-unsur yang berada pada periode yang sama memiliki jumlah kulit elektron terisi yang sama.',

            'Contohnya, natrium (Na) dan magnesium (Mg) sama-sama berada pada periode 3. Keduanya memiliki elektron yang menempati tiga kulit utama.',
          ],
        ),

        MaterialSection(
          title: 'Apa Itu Golongan?',
          paragraphs: [
            'Selain baris mendatar, tabel periodik juga punya kolom vertikal yang disebut golongan.',

            'Unsur-unsur dalam satu golongan biasanya memiliki kemiripan sifat kimia. Hal ini berkaitan dengan pola susunan elektron, terutama elektron yang terlibat dalam pembentukan ikatan.',

            'Sebagai contoh, litium (Li), natrium (Na), dan kalium (K) berada dalam golongan 1. Ketiganya termasuk logam alkali dan memiliki satu elektron valensi.',

            'Karena susunan elektron terluarnya mirip, ketiga unsur tersebut juga menunjukkan beberapa sifat kimia yang mirip, seperti mudah membentuk ion bermuatan positif satu.',
          ],
        ),

        MaterialSection(
          title: 'Logam, Nonlogam, dan Metaloid',
          paragraphs: [
            'Unsur-unsur dalam tabel periodik juga bisa dikelompokkan berdasarkan sifatnya. Tiga kelompok yang perlu kamu kenali adalah logam, nonlogam, dan metaloid.',

            '1. Logam\nSebagian besar unsur dalam tabel periodik termasuk logam. Logam umumnya dapat menghantarkan panas dan listrik dengan baik. Contohnya adalah besi (Fe), tembaga (Cu), dan aluminium (Al).',

            '2. Nonlogam\nNonlogam memiliki sifat yang beragam dan umumnya tidak menghantarkan listrik sebaik logam. Contohnya adalah oksigen (O), karbon (C), dan sulfur (S).',

            '3. Metaloid\nMetaloid memiliki sifat yang berada di antara logam dan nonlogam. Contohnya adalah silikon (Si) dan germanium (Ge), yang banyak digunakan sebagai bahan semikonduktor dalam perangkat elektronik.',
          ],
        ),

        MaterialSection(
          title: 'Kenapa Posisi Unsur Itu Penting?',
          paragraphs: [
            'Posisi suatu unsur dalam tabel periodik bisa memberi kita petunjuk tentang sifatnya. Jadi, tabel periodik bukan hanya daftar nama unsur yang harus dihafalkan.',

            'Misalnya, unsur-unsur golongan 18 dikenal sebagai gas mulia. Sebagian besar unsur dalam golongan ini memiliki kulit elektron terluar yang sudah terisi penuh sehingga relatif sulit bereaksi dalam kondisi biasa.',

            'Sebaliknya, unsur-unsur golongan 1 cenderung mudah melepaskan satu elektron dan membentuk ion positif.',

            'Dengan memahami pola seperti ini, kamu bisa mulai memperkirakan perilaku suatu unsur hanya dengan melihat posisinya di tabel periodik.',
          ],
        ),

        MaterialSection(
          title: 'Kesimpulan',
          paragraphs: [
            'Tabel periodik membantu kita mengenali unsur-unsur kimia dan memahami hubungan antara sifat serta struktur atomnya.',

            'Periode menunjukkan baris mendatar, sedangkan golongan menunjukkan kolom vertikal. Posisi unsur dalam tabel juga bisa memberikan petunjuk tentang susunan elektron dan sifat kimianya.',

            'Kalau kamu sudah memahami cara membaca tabel periodik, mempelajari unsur dan reaksi kimia berikutnya akan terasa lebih mudah.',
          ],
        ),
      ],
    ),

    MaterialModel(
      topicId: 'chemical_bonding',
      sections: [
        MaterialSection(
          title: 'Apa Itu Ikatan Kimia?',
          paragraphs: [
            'Pernah kepikiran kenapa atom hidrogen dan oksigen bisa bergabung membentuk air? Padahal, keduanya merupakan unsur yang berbeda dengan sifat yang berbeda pula.',

            'Salah satu alasan atom bisa bergabung adalah karena adanya ikatan kimia. Ikatan kimia merupakan interaksi yang membuat atom atau ion dapat bergabung membentuk suatu zat.',

            'Saat ikatan terbentuk, susunan partikel yang dihasilkan bisa memiliki energi lebih rendah dibandingkan ketika partikel-partikelnya terpisah. Kondisi ini membuat susunan tersebut lebih stabil.',

            'Ikatan kimia punya peran besar dalam kehidupan sehari-hari. Air yang kamu minum, garam dapur, hingga berbagai bahan penyusun tubuh kita melibatkan ikatan kimia.',
          ],
        ),

        MaterialSection(
          title: 'Kenalan dengan Elektron Valensi',
          paragraphs: [
            'Sebelum memahami jenis-jenis ikatan kimia, ada satu istilah penting yang perlu kamu kenali, yaitu elektron valensi.',

            'Elektron valensi adalah elektron pada bagian terluar atom yang dapat terlibat dalam pembentukan ikatan kimia.',

            'Jumlah dan susunan elektron valensi memengaruhi bagaimana suatu atom berinteraksi dengan atom lain.',

            'Sebagai contoh, atom natrium memiliki satu elektron valensi dan dapat melepaskannya ketika membentuk ion Na⁺. Sementara itu, atom klorin memiliki tujuh elektron valensi dan dapat menerima satu elektron untuk membentuk ion Cl⁻.',
          ],
        ),

        MaterialSection(
          title: 'Ikatan Ion',
          paragraphs: [
            'Ikatan ion terbentuk karena adanya gaya tarik listrik antara ion bermuatan positif dan ion bermuatan negatif.',

            'Salah satu cara ion-ion tersebut terbentuk adalah melalui perpindahan elektron dari satu atom ke atom lain.',

            'Contohnya adalah pembentukan natrium klorida (NaCl), yaitu senyawa yang kita kenal sebagai garam dapur.',

            'Atom natrium dapat melepaskan satu elektron dan berubah menjadi ion Na⁺. Elektron tersebut dapat diterima oleh atom klorin sehingga terbentuk ion Cl⁻.',

            'Karena memiliki muatan yang berlawanan, kedua ion saling tarik-menarik. Dalam garam padat, ion-ion ini tersusun membentuk struktur kristal.',
          ],
        ),

        MaterialSection(
          title: 'Ikatan Kovalen',
          paragraphs: [
            'Kalau ikatan ion melibatkan gaya tarik antara ion positif dan negatif, ikatan kovalen terbentuk ketika dua atom menggunakan pasangan elektron secara bersama-sama.',

            'Ikatan ini banyak ditemukan pada zat yang tersusun dari unsur-unsur nonlogam.',

            'Contohnya adalah molekul air (H₂O). Dalam molekul air, atom oksigen membentuk ikatan kovalen dengan dua atom hidrogen melalui penggunaan pasangan elektron bersama.',

            'Contoh lainnya adalah molekul oksigen (O₂). Dua atom oksigen berbagi dua pasangan elektron sehingga terbentuk ikatan kovalen rangkap dua.',

            'Dengan berbagi elektron, atom-atom dapat membentuk susunan yang lebih stabil.',
          ],
        ),

        MaterialSection(
          title: 'Ikatan Logam',
          paragraphs: [
            'Pernah bertanya-tanya kenapa kabel listrik banyak menggunakan tembaga? Salah satu alasannya berkaitan dengan ikatan logam.',

            'Ikatan logam adalah interaksi yang menyatukan atom-atom dalam struktur logam. Elektron valensi pada logam dapat bergerak relatif bebas di antara banyak atom dan tidak hanya terikat pada satu atom tertentu.',

            'Pergerakan elektron tersebut membantu menjelaskan kenapa logam umumnya dapat menghantarkan listrik dan panas dengan baik.',

            'Selain itu, banyak logam juga bisa dibentuk menjadi lembaran atau ditarik menjadi kawat tanpa langsung patah. Sifat ini membuat logam banyak digunakan dalam berbagai peralatan sehari-hari.',
          ],
        ),

        MaterialSection(
          title: 'Apa Bedanya Ketiga Ikatan Ini?',
          paragraphs: [
            'Sekarang kamu sudah mengenal tiga jenis ikatan kimia utama. Perbedaan ketiganya terletak pada bagaimana elektron terlibat dan gaya yang menyatukan partikel-partikelnya.',

            'Pada ikatan ion, ion positif dan ion negatif saling tarik-menarik. Ion-ion tersebut dapat terbentuk ketika elektron berpindah dari satu atom ke atom lain.',

            'Pada ikatan kovalen, dua atom berbagi pasangan elektron untuk membentuk ikatan.',

            'Sementara itu, pada ikatan logam, elektron dapat bergerak di antara banyak atom logam dan membantu menyatukan struktur logam tersebut.',

            'Perbedaan jenis ikatan ini ikut memengaruhi sifat suatu zat, seperti kemampuan menghantarkan listrik, titik leleh, dan sifat fisik lainnya.',
          ],
        ),

        MaterialSection(
          title: 'Kesimpulan',
          paragraphs: [
            'Ikatan kimia memungkinkan atom dan ion bergabung membentuk berbagai zat yang kita temui dalam kehidupan sehari-hari.',

            'Tiga jenis ikatan yang sudah kamu pelajari adalah ikatan ion, ikatan kovalen, dan ikatan logam. Masing-masing punya cara berbeda dalam melibatkan elektron dan menyatukan partikel.',

            'Kalau kamu memahami bagaimana ikatan terbentuk, kamu akan lebih mudah memahami kenapa setiap zat memiliki sifat yang berbeda-beda.',
          ],
        ),
      ],
    ),
  ];

  static MaterialModel? findByTopicId(String topicId) {
    for (final material in items) {
      if (material.topicId == topicId) {
        return material;
      }
    }

    return null;
  }
}
