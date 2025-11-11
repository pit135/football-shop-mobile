# pf_shop

=============================================================== TUGAS 7 =====================================================================

1. Apa itu Widget Tree pada Flutter dan bagaimana hubungan parent-child bekerja antar widget
=> Widget Tree adalah struktur hierarki dari semua widget yang membentuk interface aplikasi flutter, setiap tampilan (UI) di Flutter dibangun dari kumpulan widget yang saling bersarang (nested), dari atas ke bawah
-> parent widget adalah widget yang membungkus widget lain
-> child widget adalah widget yang berada di dalam parent-nya

-> contoh sederhana:
Scaffold(
  appBar: AppBar(title: Text('contoh')),
  body: Center(
    child: Text('Halo Dunia'),
  ),
)

=> Hubungan Parent–Child:
Parent menentukan layout & posisi anak-anaknya (child), sedangkan child menentukan isi atau tampilan di dalam parent, jadi widget tree adalah struktur dasar bagaimana Flutter merender UI ke layar



2. Sebutkan semua widget yang digunakan dalam proyek ini dan fungsinya

- MaterialApp => Root aplikasi, menyediakan tema, routing, dan integrasi Material Design
- Scaffold => Menyediakan struktur dasar layar seperti AppBar, body, FloatingActionButton
- AppBar => Menampilkan bar di bagian atas layar dengan judul
- Text => Menampilkan teks di layar
- Column => Menyusun widget anak secara vertikal
- Row => Menyusun widget anak secara horizontal
- Container => Membungkus widget lain dan memberi padding, margin, border, atau warna background
- Card => Widget berbingkai dan memiliki efek bayangan untuk menampilkan konten terpisah
- Padding => Memberikan jarak di dalam widget (inner spacing)
- Expanded => Mengisi ruang kosong di dalam Row atau Column
- Icon => Menampilkan ikon dari pustaka Material Icons
- ElevatedButton.icon => Tombol dengan ikon dan teks, digunakan untuk aksi pengguna
- SingleChildScrollView => Agar konten bisa di-scroll jika melebihi tinggi layar
- GridView.count => Menyusun widget anak dalam bentuk grid dengan jumlah kolom tetap
- SnackBar => Menampilkan notifikasi sementara di bagian bawah layar
- InkWell => Memberikan efek sentuh (ripple effect) pada widget
- SizedBox => Memberi jarak atau ukuran tetap di antara widget
- InfoCard (custom widget) => Menampilkan informasi nama, NPM, dan kelas dalam bentuk card kecil
- ItemButton (custom widget) => Membuat tombol persegi panjang untuk All Products, My Products, dan Create Product



3. Fungsi dari widget MaterialApp dan mengapa sering digunakan sebagai widget root

MaterialApp adalah widget utama (root) yang digunakan untuk membungkus seluruh aplikasi Flutter berbasis Material Design
Fungsinya:
- Menentukan tema global aplikasi (ThemeData)
- Menentukan halaman utama melalui properti home
- Mengatur navigasi & routing antar halaman
- Mengatur judul aplikasi, debug banner, dan localization
Mengapa sering digunakan sebagai root, karena hampir semua aplikasi Flutter modern mengikuti prinsip Material Design, MaterialApp menjadi fondasi agar widget seperti Scaffold, AppBar, TextField, dll dapat tampil dengan gaya dan perilaku yang konsisten




4. Perbedaan antara StatelessWidget dan StatefulWidget
Aspek  ------------------------  StatelessWidget  ---------------------------  StatefulWidget

State (keadaan) ------- Tidak berubah (immutable) setelah dibuat ---  Dapat berubah selama aplikasi berjalan
Kapan digunakan	------- Untuk tampilan statis yang tidak berubah ---  Untuk tampilan dinamis yang berubah karena interaksi pengguna atau data baru
Contoh penggunaan ----- Teks, ikon, layout statis ------------------  Form, counter, tombol favorit, animasi
Metode utama ---------- build(BuildContext context) ---------------- createState() → menghasilkan State class yang punya build() dan setState()

contoh:

// StatelessWidget
class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text("Halo");
}

// StatefulWidget
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}
class _CounterState extends State<Counter> {
  int count = 0;
  @override
  Widget build(BuildContext context) => 
    ElevatedButton(
      onPressed: () => setState(() => count++),
      child: Text("Klik: $count"),
    );
}




5. Apa itu BuildContext dan mengapa penting di Flutter?

BuildContext adalah objek yang mewakili posisi sebuah widget di dalam widget tree, setiap widget di Flutter memiliki BuildContext, dan konteks ini digunakan untuk:
- Mengakses widget induk (parent) di atasnya
- Menemukan tema (Theme.of(context)), navigator (Navigator.of(context)), atau Scaffold (ScaffoldMessenger.of(context))
- Mengatur hierarki tampilan dan gaya visual

contoh penggunaan dalam build():
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Halo', style: Theme.of(context).textTheme.titleLarge),
    ),
  );
}

Tanpa BuildContext, Flutter tidak tahu widget berada di posisi mana di pohon widget, sehingga tidak bisa mewarisi data seperti tema, navigator, dll




6. Jelaskan konsep “Hot Reload” dan perbedaannya dengan “Hot Restart”
Fitur ------------------------------------ Hot Reload ------------------------------------------------------ Hot Restart

Apa yang dilakukan ------ Memperbarui kode tanpa menghapus state aplikasi -------------- Memulai ulang aplikasi dari awal dan menghapus semua state
Kecepatan --------------- Sangat cepat (karena hanya menimpa kode di memori) ----------- Lebih lambat, karena seluruh aplikasi direstart ulang
Kapan digunakan	--------- Saat mengubah UI, teks, style, layout ------------------------ Saat mengubah variabel global, struktur state, atau inisialisasi data awal
Contoh ------------------ Mengubah warna tombol → tidak kehilangan data ---------------- Mengubah variabel di main() → perlu restart agar diterapkan

contoh:
- sedang mengetes warna tombol → cukup Hot Reload
- menambahkan variabel baru di main.dart → perlu Hot Restart












=============================================================== TUGAS 8 =====================================================================

1. Bedanya Navigator.push() vs Navigator.pushReplacement(), dan kapan saya pakai

a) Navigator.push()
=> Navigator.push() itu kayak numpuk halaman baru di atas halaman lama, halaman lama masih ada di stack, jadi kalau user pencet tombol back, dia bakal balik lagi ke halaman sebelumnya
=> Contoh di app saya:
kalo dari halaman utama saya mau ke form tambah produk, saya pakai:
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const NewsFormPage()),
);
=> Kenapa? Karena setelah user isi form dan selesai, wajar kalau dia balik lagi ke halaman utama dengan back

b) Navigator.pushReplacement()
=> Navigator.pushReplacement() itu mengganti halaman sekarang dengan halaman baru, halaman lama dibuang dari stack, jadi tombol back nggak akan balik ke halaman sebelumnya itu
=> Di aplikasi saya, ini kepake di Drawer
Misalnya dari form atau halaman lain, user pilih menu “Halaman Utama” di drawer:
Navigator.pushReplacementNamed(context, '/');
=> Kenapa pakai replacement?
Supaya stack nggak numpuk banyak halaman yang sebenarnya sama-sama home. Jadi setiap kali pindah lewat drawer, halaman lama diganti, bukan ditumpuk.

Singkatnya:
- push() => buat navigasi normal (perjalanan maju yang nanti masih mungkin balik)
- pushReplacement() => buat pindah halaman, misalnya dari drawer, atau setelah login, supaya user nggak bisa balik ke halaman sebelumnya yang udah nggak relevan



2. Gimana saya pakai Scaffold, AppBar, Drawer supaya layout konsisten
Di aplikasi Football Shop, saya bikin pola dasar halaman yang sama di semua screen:

=> Scaffold
Ini jadi kerangka utama setiap layar
Di semua halaman (halaman utama dan form), saya selalu bungkus konten dengan Scaffold, supaya punya slot:
appBar
drawer
body
=> Contoh:
return Scaffold(
  appBar: AppBar(...),
  drawer: const LeftDrawer(),
  body: ...,
);

=> AppBar
Judulnya saya samain yaitu “Football Shop” biar user ngerasa masih di app yang sama, warna AppBar juga konsisten (hijau) supaya kuat identitas brand tokonya, di atas halaman utama maupun form, AppBar ini selalu ada, cuma isi subtitle/konten di bawahnya yang berubah

=> Drawer (LeftDrawer)
Saya bikin LeftDrawer sebagai widget terpisah, di dalamnya ada dua menu utama:
- Halaman Utama
- Tambah Produk
Terus saya reuse di semua screen dengan:
drawer: const LeftDrawer(),
Jadi, di halaman mana pun user berada, pengalaman navigasinya sama, tinggal tarik dari kiri, dan pilihan menunya selalu konsisten

Dengan cara ini, saya nggak bikin layout tiap halaman dari nol, tapi ngikutin kerangka yang sama: Scaffold + AppBar + Drawer => tinggal ganti isi body aja



3. Kenapa saya pakai Padding, SingleChildScrollView, ListView di form
di halaman form tambah produk, saya banyak pakai widget layout buat ngebantu tampilan dan UX:
a) Padding
- fungsinya itu ngasih jarak biar elemen-elemen nggak mepet ke pinggir layar, tanpa padding, form kelihatan sesek/padey dan susah dibaca
- contoh di form saya:
Padding(
  padding: const EdgeInsets.only(bottom: 16.0),
  child: TextFormField(
    decoration: InputDecoration(
      labelText: "Nama Produk",
      ...
    ),
    ...
  ),
),
di sini saya kasih padding bawah 16 pixel di tiap field, supaya antar field ada jarak yang sesuai

b) SingleChildScrollView
ini penting biar form bisa discroll kalau kontennya panjang atau layar kecil (misalnya HP dengan keyboard kebuka), tanpa ini, bisa terjadi overflow (muncul pesan kuning merah di bawah)
di app saya, seluruh form dibungkus:
SingleChildScrollView(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    children: [
      // semua TextFormField, Dropdown, Switch, dll
    ],
  ),
)
jadi meskipun field banyak (nama, harga, deskripsi, kategori, url, switch), user tetap bisa scroll saampe bawah

c. ListView / ListBody
di popup (AlertDialog) setelah user klik save, saya pakai ListBody (atau bisa ListView) buat menyusun teks hasil input secara rapi ke bawah:
content: SingleChildScrollView(
  child: ListBody(
    children: [
      Text('Nama: $nameState'),
      Text('Harga: $priceState'),
      ...
    ],
  ),
),

=> keuntungannya kalo datanya agak panjang (misalnya deskripsi produk panjang), konten dialog masih bisa discroll dan nggak kepotong

=> Intinya:
- Padding => bikin tampilan rapi
- SingleChildScrollView => mencegah overflow, form bisa discroll
- ListView/ListBody => nampilin banyak baris konten dengan layout vertikal yang rapih




4. Gimana saya nurunin tema warna biar konsisten dengan brand Football Shop
di aplikasi saya, saya pengen brand nya kerasa hijau gitu, kaya lapangan bola, jadinya
- atur tema global di MaterialApp
- di main.dart, saya set color scheme utama:
return MaterialApp(
  title: 'Football Shop',
  theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
    ).copyWith(
      secondary: Colors.greenAccent[400],
    ),
    useMaterial3: true,
  ),
  ...
);
primarySwatch: Colors.green => bikin warna utama app hijau (AppBar, fokus form, tombol, dll ikut tone hijau)
secondary saya pilih ijo yang lebih terang buat aksen

=> samain warna di AppBar dan Drawer
- di AppBar:
appBar: AppBar(
  backgroundColor: Colors.green.shade700,
  title: const Text('Football Shop'),
  ...
),

- di DrawerHeader:
decoration: BoxDecoration(
  color: Colors.green.shade700,
),

=> jadi user selalu ngeliat hijau yang sama di area navigasi utama
gunakan warna serupa di background dan kartu, background halaman utama saya pakai hijau muda:
body: Container(
  color: Colors.green.shade50,
  ...
),
kartu menu (All Products, My Products, Create Product) warnanya biru, hijau, merah, tapi AppBar dan header tetap hijau, jadi brand utama tetap kebaca

=> Form & fokus field
karena primary color hijau, saat user tap TextFormField, garis fokus dan label yang naik ikut warna hijau juga, jadi makin nyatu dengan identitas “Football Shop”