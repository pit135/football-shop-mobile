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
Metode utama ---------- build(BuildContext context) ---------------- createState() => menghasilkan State class yang punya build() dan setState()

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
Contoh ------------------ Mengubah warna tombol => tidak kehilangan data ---------------- Mengubah variabel di main() => perlu restart agar diterapkan

contoh:
- sedang mengetes warna tombol => cukup Hot Reload
- menambahkan variabel baru di main.dart => perlu Hot Restart












=============================================================== TUGAS 8 =====================================================================

1. Bedanya Navigator.push() vs Navigator.pushReplacement(), dan kapan saya pakai

a) Navigator.push()
=> Navigator.push() itu kayak numpuk halaman baru di atas halaman lama, halaman lama masih ada di stack, jadi kalo user pencet tombol back, dia bakal balik lagi ke halaman sebelumnya
=> Contoh di app saya:
kalo dari halaman utama saya mau ke form tambah produk, saya pakai:
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const NewsFormPage()),
);
=> Kenapa? Karena setelah user isi form dan selesai, wajar kalo dia balik lagi ke halaman utama dengan back

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
ini penting biar form bisa discroll kalo kontennya panjang atau layar kecil (misalnya HP dengan keyboard kebuka), tanpa ini, bisa terjadi overflow (muncul pesan kuning merah di bawah)
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



=============================================================== TUGAS 9 =====================================================================


1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?

Intinya: model Dart = “kontrak” bentuk data kita, kalo cuma pake Map<String, dynamic>, kita kehilangan semua perlindungan itu

keuntungan pakai model (class):

misal:
class Product {
  final int id;
  final String name;
  final int price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
      };
}


a) Validasi tipe & compile-time checking
Dengan model, field punya tipe yang jelas: id harus int, name harus String, dll. kalo kita salah pakai (misal product.price.toUpperCase()), langsung error di compile-time, sebelum app jalan. IDE juga bisa bantu auto-complete (product.name, product.price, dll).
kalo cuma:
Map<String, dynamic> p = jsonDecode(...);
print(p['price']); // dynamic, bisa String? int? null?
Tipe-nya dynamic, jadi kesalahan baru ketahuan saat runtime (app sudah jalan di emulator/HP => tiba-tiba crash).

b) Null-safety yang beneran kepake
Dengan model:
final String name;           // wajib ada
final String? description;   // boleh null
kita “maksa” data punya bentuk tertentu
kalo API berubah dan misalnya name jadi kadang nggak dikirim, kita akan kepaksa memperbaiki kode (dan itu bagus => ketahuan cepat).
Dengan Map<String, dynamic>:
final name = p['name']; // dynamic, bisa null, bisa String, bisa apapun
Null-safety Dart jadi setengah kepake, karena semua dynamic.

c) Maintainability & skalabilitas
Waktu app masih kecil mungkin kerasa ribet bikin model.
Tapi:
- Field nambah
- JSON makin kompleks (nested)
- Ada banyak halaman pakai data yang sama
Model bikin:
- Perubahan cukup di satu tempat (Product class)
- Semua kode lain ikut “aman”.
kalo kita pakai Map di banyak tempat:
- Salah tulis key dikit aja ("prcie" instead of "price") => gak ada - yang ngasih tau sampai runtime.
kalo API ubah nama field => kita harus cari & ganti di semua file yang pakai string key itu.
Jadi: bisa pakai Map<String, dynamic> langsung, tapi:
Lebih riskan error runtime,
Null-safety kurang berguna,
Susah dirawat kalo project makin besar.













2. Fungsi package http dan CookieRequest. Bedanya apa?
Dalam tugas PBP:
package:http
Ini library HTTP umum di Flutter.
Fungsinya:
- Kirim request: GET, POST, dll.
- Kirim body, header, dll.
Tapi:
- Dia tidak punya manajemen cookie/session otomatis.
- Tiap request dianggap stateless; kalo mau simpan cookie, kita sendiri yang urus.
Dipakai misalnya:
- Untuk fetch data publik (yang tidak butuh login),
- Atau request yang nggak butuh state sesi.
- CookieRequest (dari pbp_django_auth)
Ini wrapper khusus yang:
- Nyimpen dan ngirim cookie secara otomatis (termasuk sessionid, csrftoken dari Django).

Punya method khusus: login, logout, get, post.
Fungsinya:
Biar sesi Django (session-based auth) bisa dipakai dari Flutter.
Semua request setelah login otomatis bawa cookie => Django bisa tahu user mana yang request.

Jadi singkatnya:
- http => “kabel HTTP mentah”, kita yang ngatur segalanya.
- CookieRequest => “kabel HTTP + dompet cookie + helper login/logout”, didesain khusus untuk integrasi dengan Django session auth.








3. Kenapa instance CookieRequest harus dibagi ke semua komponen?
Karena:
CookieRequest menyimpan:
- Cookie sesi (sessionid, csrftoken) yang didapat waktu login.
- Status login (misal loggedIn == true).
- kalo kita bikin instance baru di tiap halaman:
- final request = CookieRequest(); // baru lagi
Instance ini tidak punya cookie yang didapat saat login. Jadi ketika kita request ke endpoint yang butuh login: 
- Django tidak menerima cookie sessionid yang benar => anggap kita belum login.
Karena itu di tutorial:
CookieRequest dibuat satu kali, lalu Dibagikan ke seluruh widget pakai Provider (ChangeNotifierProvider / Provider biasa). Semua halaman pakai instance yang sama:
final request = context.watch<CookieRequest>();
kalo nggak dibagi:
Login kelihatannya sukses di satu halaman, Tapi halaman lain waktu fetch data, Akhirnya data protected nggak bisa diambil, menu yang harusnya muncul setelah login nggak muncul, dll.








4. Konfigurasi konektivitas Flutter ↔ Django
Ada beberapa bagian penting:

a) 10.0.2.2 di ALLOWED_HOSTS (Django)
Di Android emulator, localhost laptop kita dilihat sebagai 10.0.2.2.
Saat Flutter (di emulator) mengakses http://10.0.2.2:8000, Django akan menganggap hostnya 10.0.2.2.
Django punya setting ALLOWED_HOSTS, misal:
ALLOWED_HOSTS = ["10.0.2.2", "localhost", "127.0.0.1"]
kalo 10.0.2.2 tidak ada di situ:
Django melempar error: "Invalid HTTP_HOST header" dan balas 400.
Di Flutter, kita cuma lihat gagal fetch / response error.

b) CORS & pengaturan SameSite/cookie
Terutama penting kalo:
kita jalankan Flutter Web (origin berbeda dari Django), atau Perlu kirim cookie dengan aturan SameSite tertentu.
Yang diatur biasanya:
CORS_ALLOW_ALL_ORIGINS atau CORS_ALLOWED_ORIGINS
CSRF_TRUSTED_ORIGINS
SESSION_COOKIE_SAMESITE
CSRF_COOKIE_SAMESITE
Kadang SESSION_COOKIE_SECURE, CSRF_COOKIE_SECURE.
kalo CORS/CSRF/cookie tidak diatur benar:
Browser (untuk Flutter Web) akan:
Blokir request atau Tidak mau mengirim/menyimpan cookie dari Django.

Akibatnya:
Login kelihatan “berhasil” di sisi API (misal respon JSON ok),
Tapi cookie sessionid tidak pernah nempel di browser / CookieRequest => request berikutnya tetap dianggap belum login. Di mobile (Android/iOS), CORS tidak di-enforce oleh OS, tapi pengaturan cookie & CSRF tetap penting untuk session-based auth.

c) Izin akses internet di Android (AndroidManifest.xml)
Di android/app/src/main/AndroidManifest.xml harus ada:
<uses-permission android:name="android.permission.INTERNET" />
kalo ini tidak ada:
Aplikasi Android kita tidak diizinkan mengakses jaringan. Di Flutter, setiap request http/CookieRequest akan gagal, Biasanya muncul error seperti SocketException: Failed host lookup atau semacamnya. UI akan gagal muat data, mungkin cuma loading terus / error.
Jadi kalo konfigurasi salah:\
Tidak bisa konek ke Django (400, koneksi gagal),
Cookie session tidak terkirim => selalu dianggap belum login,
Di Flutter, data tidak muncul, login tidak “nempel”, dll.







5. Mekanisme pengiriman data: dari input => Django => tampil di Flutter
Gambaran alurnya:
User isi form di Flutter
Misal form tambah produk: TextField untuk nama, harga, dll.
Masing-masing punya TextEditingController.
User klik tombol “Submit”
Di onPressed, kita ambil nilai:
final name = nameController.text;
final price = int.parse(priceController.text);
Flutter kirim request ke Django
Pakai CookieRequest.post atau http.post ke URL Django, misal /create-product/.

Data dikirim sebagai:
JSON body, atau
Form-url-encoded (tergantung implementasi view di Django).
Django terima request
View Django membaca data:
request.POST[...] (kalo form), atau json.loads(request.body) (kalo JSON).

Django validasi:
Field wajib diisi?
Tipe benar?
User sudah login?
kalo valid:
Data disimpan ke database (misalnya pakai Product.objects.create(...)).
Django mengirim respon
Biasanya dalam bentuk JSON, misal:
{
  "status": "success",
  "message": "Product created",
  "product": { ... }
}

Flutter menerima respon
CookieRequest.post / http.post mengembalikan body respon.
kita jsonDecode, lalu:
Diubah ke model Dart (Product.fromJson(...)),
Atau dipakai langsung.
State Flutter di-update => UI rebuild
Data baru dimasukkan ke list state:
setState(() {
  products.add(newProduct);
});
Widget yang menampilkan list produk (ListView.builder) akan rebuild dan tiba-tiba item baru muncul di layar.







6. Mekanisme autentikasi: login, register, logout (Django ↔ Flutter)

a) Register
User isi form register di Flutter
Username, password, konfirmasi, dll.
Flutter kirim data ke Django
CookieRequest.post("/auth/register/", {...}) (atau URL yang ditentukan).
Django register view:
Ambil data dari request.
Cek:
Username sudah dipakai?
Password valid?
kalo oke:
Buat user baru dengan User.objects.create_user(...).
Balikkan JSON, misalnya { "status": "success" }.
Kadang:
Langsung login-kan user,
Kadang user disuruh login lagi secara terpisah.
Flutter baca respon
kalo sukses:
Tampilkan snackbar / pesan,
Arahkan ke halaman login.

b) Login
User isi username & password di Flutter
Flutter panggil CookieRequest.login(url, data)
Misalnya: await request.login("http://10.0.2.2:8000/auth/login/", data);
Django login view (biasanya pakai django.contrib.auth):
Cek username & password dengan authenticate(...).
kalo benar:
Panggil login(request, user) => Django:
Buat session di database,
Kirim Set-Cookie: sessionid=... di response.
CookieRequest menyimpan cookie
Library pbp_django_auth otomatis:
Menyimpan sessionid & csrftoken ke dalam CookieRequest.
Set request.loggedIn = true dan menyimpan informasi user (kalo disediakan).
Flutter navigasi ke menu utama
Setelah login() return dan loggedIn == true:
kita Navigator.pushReplacement ke halaman menu.
Di halaman menu, kita tetap pakai context.watch<CookieRequest>() yang sama.
Semua request setelah ini otomatis bawa cookie sessionid, sehingga:
Django tahu user yang request,
Endpoint yang butuh login akan mengizinkan.

c) Akses endpoint setelah login

Misal kita memanggil endpoint /json/my-items/:
Flutter:
request.get("http://10.0.2.2:8000/json/my-items/")
CookieRequest:
Mengirim header dengan cookie sessionid yang sudah disimpan saat login.
Django:
Baca sessionid,
Rekonstruksi request.user dari session,
kalo pakai @login_required, user boleh mengakses.
Django kirim balik JSON berisi item milik user.
Flutter:
Decode JSON => list model => tampilkan di UI (misalnya My Items).

d) Logout
User pencet tombol logout di Flutter
Flutter panggil request.logout(url)
Misal: /auth/logout/.
Django logout view:
Panggil logout(request):
Hapus session dari server,
Cookie sessionid direset (expired).
CookieRequest:
Menghapus cookie internal,
Set loggedIn = false.
Flutter:
Biasanya:
Navigasi balik ke halaman login,
Atau sembunyikan menu yang butuh login.
Setelah logout:
kalo kita masih coba akses endpoint yang butuh login:
CookieRequest sudah tidak punya sessionid.
Django akan anggap user anonymous dan:
Bisa lempar 401/403,
Atau balikan data kosong, tergantung implementasi.