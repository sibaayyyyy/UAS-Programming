import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login_page.dart'; // <-- import baru
// ignore: depend_on_referenced_packages

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Custom light theme based on a seed color, plus a complementary dark theme.
    const seedColor = Colors.indigo;
    final lightScheme = ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.light);
    final darkScheme = ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark);

    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: lightScheme,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: lightScheme.primary,
        foregroundColor: lightScheme.onPrimary,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: lightScheme.onPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightScheme.primary,
          foregroundColor: lightScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightScheme.primary,
          side: BorderSide(color: lightScheme.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: lightScheme.primary)),
        labelStyle: TextStyle(color: Colors.grey.shade700),
      ),
      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 6),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightScheme.primary,
        foregroundColor: lightScheme.onPrimary,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 3,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: lightScheme.primary,
        contentTextStyle: TextStyle(color: lightScheme.onPrimary),
      ),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: darkScheme,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        backgroundColor: darkScheme.primary,
        foregroundColor: darkScheme.onPrimary,
        elevation: 2,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkScheme.primary,
          foregroundColor: darkScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade900,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: darkScheme.primary)),
        labelStyle: TextStyle(color: Colors.grey.shade300),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkScheme.primary,
        foregroundColor: darkScheme.onPrimary,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: darkScheme.primary,
        contentTextStyle: TextStyle(color: darkScheme.onPrimary),
      ),
    );

    return MaterialApp(
      title: 'Form Pilihan',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const LoginPage(), // start at login
      routes: {
        '/home': (_) => const Home(), // Home tetap ada di main.dart
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class TicketOrder {
  String nama;
  String email;
  String nomorHp;
  String stasiunAsal;
  String stasiunTujuan;
  String tanggal;
  int jumlahTiket;
  String kelasKereta;

  TicketOrder({
    required this.nama,
    required this.email,
    required this.nomorHp,
    required this.stasiunAsal,
    required this.stasiunTujuan,
    required this.tanggal,
    required this.jumlahTiket,
    required this.kelasKereta,
  });
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nomorHpController = TextEditingController();
  // final _stasiunAsalController = TextEditingController();
  // final _stasiunTujuanController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _jumlahTiketController = TextEditingController();

  final List<String> _stasiunList = [
    'Gambir',
    'Pasar Senen',
    'Bandung',
    'Yogyakarta',
    'Surabaya Gubeng',
    'Semarang Tawang',
    'Solo Balapan',
    'Malang',
    // Tambahkan stasiun lain sesuai kebutuhan
  ];

  final List<String> _kelasKeretaOptions = [
    'Ekonomi',
    'Bisnis',
    'Eksekutif',
  ];

  String? _selectedStasiunAsal;
  String? _selectedStasiunTujuan;
  String? _selectedKelasKereta;
  List<TicketOrder> _orderList = [];
  int? _editingIndex;

  @override
  void dispose() {
    _nameController.dispose();
    _nomorHpController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _nomorHpController.clear();
    _tanggalController.clear();
    _jumlahTiketController.clear();
    _selectedStasiunAsal = null;
    _selectedStasiunTujuan = null;
    _selectedKelasKereta = null;
    _editingIndex = null;
    setState(() {});
  }

  void _submit() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final nomorHp = _nomorHpController.text.trim();
    final stasiunAsal = _selectedStasiunAsal ?? '';
    final stasiunTujuan = _selectedStasiunTujuan ?? '';
    final tanggal = _tanggalController.text.trim();
    final jumlahTiket = int.tryParse(_jumlahTiketController.text.trim()) ?? 0;
    final kelasKereta = _selectedKelasKereta;

    if (name.isEmpty || email.isEmpty || nomorHp.isEmpty || stasiunAsal.isEmpty || stasiunTujuan.isEmpty || tanggal.isEmpty || jumlahTiket <= 0 || kelasKereta == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi semua field dengan benar')),);
      return;
    }

    if (_editingIndex != null) {
      // UPDATE
      _orderList[_editingIndex!] = TicketOrder(
        nama: name,
        email: email,
        nomorHp: nomorHp,
        stasiunAsal: stasiunAsal,
        stasiunTujuan: stasiunTujuan,
        tanggal: tanggal,
        jumlahTiket: jumlahTiket,
        kelasKereta: kelasKereta,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pesanan berhasil diperbarui')),
      );
    } else {
      // CREATE
      _orderList.add(TicketOrder(
        nama: name,
        email: email,
        nomorHp: nomorHp,
        stasiunAsal: stasiunAsal,
        stasiunTujuan: stasiunTujuan,
        tanggal: tanggal,
        jumlahTiket: jumlahTiket,
        kelasKereta: kelasKereta,
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pesanan berhasil ditambahkan')),
      );
    }

    _clearForm();
    setState(() {});
  }

  void _editData(int index) {
    final data = _orderList[index];
    _nameController.text = data.nama;
    _emailController.text = data.email;
    _nomorHpController.text = data.nomorHp;
    _selectedStasiunAsal = data.stasiunAsal;
    _selectedStasiunTujuan = data.stasiunTujuan;
    _tanggalController.text = data.tanggal;
    _jumlahTiketController.text = data.jumlahTiket.toString();
    _selectedKelasKereta = data.kelasKereta;
    _editingIndex = index;
    setState(() {});
  }

  void _deleteData(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Pesanan'),
        content: const Text('Yakin ingin menghapus pesanan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              _orderList.removeAt(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Pesanan berhasil dihapus')),
              );
              setState(() {});
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _kirimDaftarPesananKeWhatsapp() async {
    if (_orderList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Belum ada pesanan yang bisa dikirim.')),
      );
      return;
    }
    String pesan = 'Daftar Pesanan Tiket Kereta:\n\n';
    for (var order in _orderList) {
      pesan +=
          '- ${order.nama} (${order.email}, ${order.nomorHp})\n  ${order.stasiunAsal} → ${order.stasiunTujuan}\n  Tanggal: ${order.tanggal}\n  Kelas: ${order.kelasKereta}\n  Jumlah: ${order.jumlahTiket}\n\n';
    }
    final url = Uri.parse(
        'https://wa.me/?text=${Uri.encodeComponent(pesan)}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka WhatsApp.')),
      );
    }
  }

  void _lihatDaftarDialog() {
    if (_orderList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Belum ada pesanan yang bisa dilihat.')),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          title: const Text('Detail Daftar Pesanan'),
          content: SizedBox(
            width: 320,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _orderList.map((order) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nama: ${order.nama}'),
                        Text('Email: ${order.email}'),
                        Text('Nomor HP: ${order.nomorHp}'),
                        Text('Stasiun Asal: ${order.stasiunAsal}'),
                        Text('Stasiun Tujuan: ${order.stasiunTujuan}'),
                        Text('Tanggal: ${order.tanggal}'),
                        Text('Kelas: ${order.kelasKereta}'),
                        Text('Jumlah Tiket: ${order.jumlahTiket}'),
                        const Divider(),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _kirimDaftarPesananKeWhatsapp();
              },
              child: const Text('Kirim ke WhatsApp'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan Tiket Kereta'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 4,
        leading: const Icon(Icons.train),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F0FF), Color(0xFFF8FBFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.blue.shade100,
                            child: Icon(Icons.train, size: 36, color: Colors.blue.shade700),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              'Form Pemesanan Tiket',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      // --- Form Input di sini (Dropdown, TextField, dsb) ---
                      // Contoh:
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _nomorHpController,
                        decoration: const InputDecoration(
                          labelText: 'Nomor HP',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _selectedStasiunAsal,
                        decoration: const InputDecoration(
                          labelText: 'Stasiun Asal',
                          prefixIcon: Icon(Icons.train),
                          border: OutlineInputBorder(),
                        ),
                        items: _stasiunList.map((stasiun) {
                          return DropdownMenuItem(
                            value: stasiun,
                            child: Text(stasiun),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedStasiunAsal = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _selectedStasiunTujuan,
                        decoration: const InputDecoration(
                          labelText: 'Stasiun Tujuan',
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(),
                        ),
                        items: _stasiunList.map((stasiun) {
                          return DropdownMenuItem(
                            value: stasiun,
                            child: Text(stasiun),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedStasiunTujuan = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _tanggalController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Tanggal Berangkat (YYYY-MM-DD)',
                          prefixIcon: Icon(Icons.date_range),
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            _tanggalController.text =
                                "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                            setState(() {});
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _jumlahTiketController,
                        decoration: const InputDecoration(
                          labelText: 'Jumlah Tiket',
                          prefixIcon: Icon(Icons.confirmation_number),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _selectedKelasKereta,
                        decoration: const InputDecoration(
                          labelText: 'Kelas Kereta',
                          prefixIcon: Icon(Icons.event_seat),
                          border: OutlineInputBorder(),
                        ),
                        items: _kelasKeretaOptions.map((kelas) {
                          return DropdownMenuItem(
                            value: kelas,
                            child: Text(kelas),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedKelasKereta = value;
                          });
                        },
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.save),
                              label: const Text('Simpan'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: _submit,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.refresh),
                              label: const Text('Reset'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.indigo,
                                side: const BorderSide(color: Colors.indigo),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: _clearForm,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: Icon(FontAwesomeIcons.list, color: Colors.white),
                          label: const Text('Lihat Daftar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: _lihatDaftarDialog,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Daftar Pesanan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              const SizedBox(height: 8),
              ..._orderList.isEmpty
                  ? [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Belum ada pesanan.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      )
                    ]
                  : _orderList.asMap().entries.map((entry) {
                      final i = entry.key;
                      final order = entry.value;
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo.shade100,
                            child: const Icon(Icons.person, color: Colors.indigo),
                          ),
                          title: Text(order.nama),
                          subtitle: Text(
                            '${order.stasiunAsal} → ${order.stasiunTujuan}\n${order.tanggal} | ${order.kelasKereta} | ${order.jumlahTiket} tiket',
                          ),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.orange),
                                onPressed: () => _editData(i),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteData(i),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Kirim Daftar Pesanan ke WhatsApp'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _kirimDaftarPesananKeWhatsapp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}