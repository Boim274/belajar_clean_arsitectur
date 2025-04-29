import 'package:belajar_clean_arsitectur/features/keranjang/data/models/keranjang_model.dart';
import 'package:belajar_clean_arsitectur/features/keranjang/domain/entities/keranjang.dart';
import 'package:belajar_clean_arsitectur/my_injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

abstract class KeranjangRemoteDataSource {
  Future<List<Keranjang>> getAllKeranjang();
  Future<Keranjang> getKeranjangById({required String id});
  // void tidak ada pengembalian
  Future<void> addKeranjang({required KeranjangModel keranjang});
  Future<void> editKeranjang({required KeranjangModel keranjang});
  Future<void> deleteKeranjang({required String id});
}

class KeranjangRemoteDataSourceImplementation
    implements KeranjangRemoteDataSource {
  //menggunakan firebase fire store
  final FirebaseFirestore firebaseFirestore;
  final user = myinjection<Box>();

  KeranjangRemoteDataSourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addKeranjang({required KeranjangModel keranjang}) async {
    final keranjangCollection = firebaseFirestore
        .collection('users')
        .doc(user.get('uid'))
        .collection('keranjang');

    final isProdukExist = await keranjangCollection
        .where('produkId', isEqualTo: keranjang.produkId)
        .get();

    if (isProdukExist.docs.isEmpty) {
      await keranjangCollection.add(keranjang.toFireStore());
    } else {
      final docId = isProdukExist.docs.first.id;
      final currentQuantity = isProdukExist.docs.first.get('quantity') as int;
      await keranjangCollection.doc(docId).update({
        'quantity': currentQuantity + 1,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Future<void> deleteKeranjang({required String id}) async {
    await firebaseFirestore
        .collection('users')
        .doc(user.get('uid'))
        .collection('keranjang')
        .doc(id)
        .delete();
  }

  @override
  Future<void> editKeranjang({required KeranjangModel keranjang}) async {
    await firebaseFirestore
        .collection('users')
        .doc(user.get('uid'))
        .collection('keranjang')
        .doc(keranjang.id)
        .update(keranjang.toFireStore());
  }

  @override
  Future<List<Keranjang>> getAllKeranjang() async {
    final data = await firebaseFirestore
        .collection('users')
        .doc(user.get('uid')) // ambil UID dari Hive Box
        .collection('keranjang') // subcollection di bawah user
        .get();

    return data.docs.map((e) => KeranjangModel.fromFirestore(e)).toList();
  }

  @override
  Future<Keranjang> getKeranjangById({required String id}) async {
    final doc = await firebaseFirestore
        .collection('users')
        .doc(user.get('uid'))
        .collection('keranjang')
        .doc(id)
        .get();

    return KeranjangModel.fromFirestore(doc);
  }
}
