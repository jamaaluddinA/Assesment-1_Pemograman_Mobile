import 'package:flutter/material.dart';
import 'package:asess1jabol/models/product.dart';
import 'package:asess1jabol/widgets/product_card.dart';

class HomeScreen extends StatefulWidget { //halaman utama (homescreen) memakai stateful karna di class homescreen ada penambahan produk dan penghapusan produk
  const HomeScreen({super.key});

  @override 
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int isSelected = 0;

  List<Product> allProducts = [
    Product(
      id: 1,
      name: 'Nike Air Red',
      category: 'Trending Now',
      price: '180.00',
      description: 'Sepatu bagus banget kaya yang bikin ini',
      image: 'assets/images/1.jpeg',
      quantity: 1,
    ),
    Product(
      id: 2,
      name: 'Ncafdad',
      category: 'Trending Now',
      price: '180.00',
      description: 'Sepatu bagus banget kaya yang bikin ini',
      image: 'assets/images/1.jpeg',
      quantity: 1,
    ),
  ];

  

  // Controller untuk input tambah produk
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // Fungsi untuk tambah produk
  void _addProduct() {
    showDialog(               //menampilkan dialog atau pop up
      context: context,       //menampilkan dialog atau pop up
      builder: (context) {    //menampilkan dialog atau pop up   
        return AlertDialog(   //tampilan dialog (ada judul, isi, dan tombol aksi).
          title: const Text('Tambah Produk Baru'),
          content: Column(    // menanmpung 2 textfield nama dan juga price
            mainAxisSize: MainAxisSize.min,  //style tinggi dialog
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Harga Produk'),
                keyboardType: TextInputType.number, 
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),  // kalo pop nutup kalo push buka pop up
              child: const Text('Batal'), 
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  allProducts.add(
                    Product(
                      id: allProducts.length + 1,
                      name: nameController.text,
                      category: 'Baru Ditambahkan',
                      price: priceController.text,
                      description: 'Produk baru dari user',
                      image: 'assets/images/1.jpeg',
                      quantity: 1,
                    ),
                  );
                });
                nameController.clear();
                priceController.clear();
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi hapus produk
  void _deleteProduct(int index) {
    setState(() {
      allProducts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tambahkan appbar dan tombol tambah
      appBar: AppBar(
        title: const Text('E-Commerce Shop'),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: _addProduct,
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,   // ngatur kalo misalnya bootstrap start dan end posisi kiri atau kanan kaya gitu
          children: [
            const Text(
              "Our Products",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProductCategory(index: 0, name: "All Products"),     // bisa dibilang ini listview.builder() kalo ga pake listview Column(
                                                                          // children: [
                                                                          //   Text('Sepatu'),
                                                                          //   Text('Jaket'),
                                                                          //   Text('Topi'),
                                                                          // ],
                _buildProductCategory(index: 1, name: "Jackets"),
                _buildProductCategory(index: 2, name: "Sneakers"),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GridView.builder(              // membuat tampilan produk berbentuk grid (2 kolom).
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,            
                  childAspectRatio: 100 / 140,  
                  crossAxisSpacing: 12,         
                  mainAxisSpacing: 12,          
                ),
                scrollDirection: Axis.vertical,
                itemCount: allProducts.length, 
                itemBuilder: (context, index) {
                  final product = allProducts[index];
                  return Stack(
                    children: [
                      ProductCard(product: product),   // memanggil widget kartu produk dari file product_card.dart.
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteProduct(index),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // tombol kategori
  _buildProductCategory({required int index, required String name}) => 
  GestureDetector(
    onTap: () => setState(() => isSelected = index),
    child: Container(
      width: 100,
      height: 40,
      margin: const EdgeInsets.only(top: 10, right: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected == index ? Colors.red : Colors.red.shade300, 
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(name, style: const TextStyle(color: Colors.white)),
    ),
  );
}
