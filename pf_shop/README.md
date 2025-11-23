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
- ItemButton (custom widget) => buat tombol persegi panjang untuk All Products, My Products, dan Create Product



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


1. Jelaskan mengapa kita perlu buat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?

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
Tipe-nya dynamic, jadi kesalahan baru ketahuan saat runtime (app udh jalan di emulator/HP => tiba-tiba crash).

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
User udh login?
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
Username udh dipakai?
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
Mengirim header dengan cookie sessionid yang udh disimpan saat login.
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
CookieRequest udh tidak punya sessionid.
Django akan anggap user anonymous dan:
Bisa lempar 401/403,
Atau balikan data kosong, tergantung implementasi.


7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)

1. Mengimplementasikan fitur registrasi akun di Flutter
a) Integrasi ke package autentikasi
Di Flutter kita udh pake:
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
Artinya, di main.dart / root kita udh membungkus app dengan Provider untuk CookieRequest, sehingga di halaman lain kita bisa akses:
final request = context.watch<CookieRequest>();

b) Halaman register.dart
Di file register.dart kita:
buat form dengan beberapa TextFormField:
- username
- password
- konfirmasi password
Menyimpan input ke variabel lokal (misal _username, _password, _passwordConfirm).
Saat tombol Register ditekan, kita:
- Validasi _formKey.currentState!.validate()
Lalu memanggil endpoint Django pakai:
final response = await request.postJson(
  "http://localhost:8000/auth/register/",
  jsonEncode({
    "username": _username,
    "password1": _password,
    "password2": _passwordConfirm,
  }),
);

Kalau response['status'] == 'success', kita:
menampilkan SnackBar "Registrasi berhasil"
mengarahkan user ke halaman login:

Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const LoginPage()),
);
jadi fitur registrasi di Flutter langsung terhubung ke view Django yang udh kita buat di aplikasi authentication (biasanya register view).

2. buat halaman login di Flutter
a) Halaman login.dart
Di file login.dart, alurnya:
Ada TextFormField untuk:
- username
- password
Tombol Login memanggil:
final response = await request.login(
  "http://localhost:8000/auth/login/",
  {
    'username': _username,
    'password': _password,
  },
);
Jika login sukses (request.loggedIn == true):
- menampilkan SnackBar sukses
- menyimpan mungkin nama user di UI (kalau kita ambil dari response)
- mengarahkan ke MyHomePage:
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const MyHomePage()),
);
Jika login gagal:
menampilkan SnackBar pesan error (misal "Username atau password salah")
dengan ini, user baru bisa mengakses fitur PF Shop (lihat All Products, My Products, tambah product) setelah login.

3. Mengintegrasikan autentikasi Django dengan Flutter
Integrasi ini terjadi di dua sisi: Django dan Flutter.
a) Sisi Django
kita udh punya aplikasi authentication dengan:
- register view
- login dan logout view
- semuanya terhubung di authentication/urls.py dan di-include ke PF_Shop/urls.py dengan prefix /auth/.
View Django mengembalikan JSON (dipakai pbp_django_auth):
- kalau login benar → Django set session + kirim info user
- kalau logout → session dihapus.
Endpoint lain (contoh create-flutter/, show-my-json/) mengandalkan request.user untuk mengetahui siapa user yang sedang login.
Contoh di view create_news_flutter yang kita modif jadi create_item_flutter:
user = request.user
new_item = Item(
    user=user,
    name=name,
    ...
)

b) Sisi Flutter
Di main.dart kita membungkus app dengan:
ChangeNotifierProvider(
  create: (_) => CookieRequest(),
  child: MyApp(),
);
Ini buat CookieRequest shared di seluruh app.
di tiap halaman (login, register, form product, list product) kita ambil instance-nya:
final request = context.watch<CookieRequest>();
saat login, CookieRequest otomatis menyimpan session cookie dari Django.
Cookie inilah yang dikirim ke endpoint lain (misalnya /create-flutter/, /show-my-json/), sehingga Django tahu user mana yang sedang mengakses.
kita juga bisa pakai request.loggedIn untuk:
Menyembunyikan / menampilkan menu tertentu
Mengarahkan ke login kalau belum login.
Jadi: autentikasi Django ↔ Flutter terhubung via pbp_django_auth + session cookie.

4. buat model kustom Item di Django (sesuai PF Shop)
Di main/models.py kita udh punya:
class Item(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    CATEGORY_CHOICES = [
        ('jersey', 'Jersey'),
        ('shoes', 'Shoes'),
        ('ball', 'Ball'),
        ('accessory', 'Accessory'),
    ]
    
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=255)
    price = models.IntegerField()
    stock = models.PositiveIntegerField(default=0)
    brand = models.CharField(max_length=100)
    size = models.CharField(max_length=50, blank=True)
    category = models.CharField(max_length=50, choices=CATEGORY_CHOICES)
    is_featured = models.BooleanField(default=False)
    description = models.TextField()
    thumbnail = models.URLField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

Penyesuaian dengan tema toko bola (PF Shop):
- category berisi tipe item sepak bola (jersey, shoes, ball, accessory).
- brand untuk merk seperti Adidas, Nike.
- is_featured untuk tandai produk unggulan.
- thumbnail menyimpan link gambar (dipakai di Flutter).
- user menyimpan pemilik produk (dipakai fitur My Products).

Model ini dipakai di semua endpoint:
/show-json/ → semua Item
/show-my-json/ → hanya Item dengan user == request.user
/create-flutter/ → buat Item baru dari Flutter.

5. Halaman daftar semua item dari endpoint JSON (All Products)
a) Endpoint di Django
kita punya view (misal show_json) yang mengembalikan semua Item dalam bentuk JSON, lalu dipetakan di main/urls.py sebagai:
path('show-json/', show_json, name='show_json'),
Inilah yang diakses Flutter.

b) Model di Flutter: product_entry.dart
kita buat model Dart yang mirror dari model Django:

class ProductEntry {
  final String id;
  final String name;
  final int price;
  final int stock;
  final String brand;
  final String size;
  final String category;
  final bool isFeatured;
  final String description;
  final String thumbnail;
  final DateTime createdAt;
  // plus: user jika kita parsing

  ProductEntry.fromJson(Map<String, dynamic> json)
      : id = json['pk'],
        name = json['fields']['name'],
        price = json['fields']['price'],
        stock = json['fields']['stock'],
        brand = json['fields']['brand'],
        size = json['fields']['size'],
        category = json['fields']['category'],
        isFeatured = json['fields']['is_featured'],
        description = json['fields']['description'],
        thumbnail = json['fields']['thumbnail'] ?? "",
        createdAt = DateTime.parse(json['fields']['created_at']);
}

c) Halaman product_list_page.dart (All Products)
Di file ini:
kita ambil data dari Django:
Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
  final response = await request.get('$baseUrl/show-json/');
  List<ProductEntry> listProducts = [];
  for (var d in response) {
    if (d != null) {
      listProducts.add(ProductEntry.fromJson(d));
    }
  }
  return listProducts;
}

Di widget:
body: FutureBuilder(
  future: fetchProducts(request),
  builder: (context, AsyncSnapshot snapshot) {
    ...
    return GridView.builder(
      ...
      itemBuilder: (_, index) {
        final product = snapshot.data![index];
        return ProductCard(
          product: product,
          onTap: () { ... },
        );
      },
    );
  },
)


Di dalam ProductCard, kita menampilkan:
- product.name
- product.price
- product.description
plus atribut lain (kategori, brand, featured, dll.).

Jadi requirement:
Tampilkan name, price, dan description
udh terpenuhi di ProductCard.

6. Halaman detail untuk setiap item
a) File product_detail.dart
Halaman ini menerima satu ProductEntry:
class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

Di build, kita menampilkan semua atribut:
Thumbnail gambar (pakai Image.network(product.thumbnail)).
- product.name
- product.price
- product.description
- product.category
- product.brand
- product.size
- product.stock
- product.isFeatured
- product.createdAt

Jadi requirement:
Tampilkan seluruh atribut pada model item kita
terpenuhi melalui elemen-elemen teks di ProductDetailPage.

b) Navigasi dari daftar ke detail
Di product_list_page.dart dan my_product_list_page.dart, di ProductCard:

return ProductCard(
  product: product,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(product: product),
      ),
    );
  },
);

Jadi saat user menekan satu card, dia diarahkan ke halaman detail dengan data lengkap item itu.

7. Tombol kembali ke daftar item
Di ProductDetailPage, kita punya tombol Detail udh di list; tapi untuk kembali ke daftar item:
kita mengandalkan AppBar default (ikon < back) karena kita pakai Navigator.push.
Selain itu bisa juga ada tombol eksplisit:
ElevatedButton(
  onPressed: () {
    Navigator.pop(context);
  },
  child: const Text('Kembali'),
)

Selama kita memanggil halaman detail dengan Navigator.push, tombol back di AppBar otomatis akan mengembalikan user ke halaman daftar (All Products atau My Products).

8. Filter daftar item → hanya milik user login (My Products)
Ini tepatnya yang dilakukan halaman My Products.
a) Endpoint baru di Django: /show-my-json/
kita buat view seperti:
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from .models import Item

@login_required(login_url='/auth/login/')
def show_my_json(request):
    items = Item.objects.filter(user=request.user)
    data = serializers.serialize('json', items)
    return HttpResponse(data, content_type='application/json')

Dan tambahkan di main/urls.py:
path('show-my-json/', show_my_json, name='show_my_json'),

View ini memastikan:
Hanya item yang user-nya sama dengan request.user yang dikirim ke Flutter.

b) Halaman my_product_list_page.dart

Di Flutter:

Future<List<ProductEntry>> fetchMyProducts(CookieRequest request) async {
  final response = await request.get('$baseUrl/show-my-json/');
  List<ProductEntry> listProducts = [];
  for (var d in response) {
    if (d != null) {
      listProducts.add(ProductEntry.fromJson(d));
    }
  }
  return listProducts;
}

Lalu di FutureBuilder, kita tampilkan data sama seperti All Products, tapi sumber datanya adalah /show-my-json/.
Hasilnya:
- All Products → ambil dari /show-json/ → semua item di database.

- My Products → ambil dari /show-my-json/ → hanya item milik user yang lagi login.
Inilah yang memenuhi requirement:
Melakukan filter pada halaman daftar item dengan hanya menampilkan item yang terasosiasi dengan pengguna yang login.