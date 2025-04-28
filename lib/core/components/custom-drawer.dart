import 'package:belajar_clean_arsitectur/my_injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = myinjection<Box>();
    

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
            currentAccountPicture: CircleAvatar(
              // backgroundImage: user?.photoURL != null
              //     ? NetworkImage(user!.photoURL!)
              //     : const AssetImage('assets/default_profile.png')
              //         as ImageProvider, // fallback foto default
              backgroundImage: const NetworkImage(
                  'https://pbs.twimg.com/profile_images/1775909266739564545/mBGUHnkP_400x400.jpg'), // fallback foto default
            ),
            accountName: Text(
              // 'Ibrahim-data-dumy',
              user.get('name') ?? 'Guest',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
            accountEmail: Text(
              user.get('email') ?? 'guest@example.com',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white70),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.shopping_bag_outlined,
                  text: 'Produk Card',
                  onTap: () => context.go('/produkCard'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.shopping_bag,
                  text: 'Produk',
                  onTap: () => context.go('/produk'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.category,
                  text: 'Kategori Produk',
                  onTap: () => context.go('/kategori'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.label,
                  text: 'Jenis Produk',
                  onTap: () => context.go('/jenis'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.warehouse,
                  text: 'Gudang',
                  onTap: () => context.go('/gudang'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.local_shipping,
                  text: 'Kurir',
                  onTap: () => context.go('/kurir'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.store,
                  text: 'Suplier',
                  onTap: () => context.go('/suplier'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.shopping_cart,
                  text: 'Keranjang',
                  onTap: () => context.go('/keranjang'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.favorite,
                  text: 'Favorite',
                  onTap: () => context.go('/favorite'),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Konfirmasi Logout'),
                    content: const Text('Yakin ingin logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Tutup dialog
                        },
                        child: const Text('Tidak'),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut(); // Logout
                          Navigator.of(context).pop(); // Tutup dialog
                          context.go('/'); // Balik ke halaman login
                        },
                        child: const Text('Ya'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
