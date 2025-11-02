# pf_shop

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