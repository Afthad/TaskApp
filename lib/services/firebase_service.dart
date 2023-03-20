

import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
  
    await reference.set(data);
  }

  Future<void> update({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);

    await reference.update(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
  
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Object data,) builder,
  Query Function(Query query)? queryBuilder,
     int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if(queryBuilder!=null){
 query = queryBuilder(query);
    }
   
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data()!,))
        
          .toList();
        
          if(sort!=null){
           result.sort(sort);
          }
     
      return result;
    });
  }

}
