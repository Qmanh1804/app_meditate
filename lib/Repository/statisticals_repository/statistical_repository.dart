import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:meditation_app/model/statistical_model.dart';

class StatisticalRepository extends GetxController {
  static StatisticalRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  // create statistical
  createStatistical(StatisticalModel statistical) async {
    DocumentReference docRef =
        await _db.collection("statisticals").add(statistical.toJson());
    String uid = docRef.id;
    // add uid enter document
    await docRef.set({"id": uid}, SetOptions(merge: true));
  }

  // update view statistical
  Future<void> updateViewStatistical(String id, int view) async {
    try {
      await _db.collection("statisticals").doc(id).update({"view": view});
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // update favourite statistical
  Future<void> updateFavouriteStatistical(String id, int favourite) async {
    try {
      await _db
          .collection("statisticals")
          .doc(id)
          .update({"favourite": favourite});
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // update download statistical
  Future<void> updateDownloadStatistical(String id, int download) async {
    try {
      await _db
          .collection("statisticals")
          .doc(id)
          .update({"download": download});
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // update idUser like, download
  Future<void> updateIduser(String id, String idUser) async {
    try {
      await _db.collection("statisticals").doc(id).update({"idUser": idUser});
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // delete idUser like, download
  Future<void> deleteIdUser(String id, String idUser) async {
    try {
      // Lấy thông tin tài liệu 'statisticals'
      final snapshot = await _db.collection('statisticals').doc(id).get();
      // Kiểm tra xem tài liệu có tồn tại không
      if (snapshot.exists) {
        // Lấy danh sách idUser từ tài liệu
        List<dynamic> idUserList = snapshot.get('idUser');

        // Kiểm tra xem idUser có tồn tại trong danh sách không
        if (idUserList.contains(idUser)) {
          // Xóa idUser khỏi danh sách
          idUserList.remove(idUser);

          // Cập nhật lại danh sách idUser trong tài liệu
          await snapshot.reference.update({'idUser': idUserList});

          //print('Xóa thành công idUser');
        } else {
          if (kDebugMode) {
            print('idUser không tồn tại trong danh sách');
          }
        }
      } else {
        if (kDebugMode) {
          print('Tài liệu không tồn tại');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // delete fullIdUser download
  Future<void> deleteFullByUserId(String userId) async {
    // Tham chiếu đến bảng "statisticals"
    CollectionReference collectionRef = _db.collection('statisticals');

    // Lấy tất cả các tài liệu trong bảng "statisticals"
    QuerySnapshot snapshot = await collectionRef.get();

    // Duyệt qua danh sách tài liệu và cập nhật danh sách idUser mới
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      var docData = doc.data();

      if (docData != null && docData is Map<String, dynamic>) {
        //xác định kiểu dữ liệu của đối tượng doc.data()
        if (docData.containsKey('idUser')) {
          var idUserList = docData['idUser'];
          int totalDownload = docData['download'];
          if (idUserList is List<dynamic>) {
            // Kiểm tra nếu userId có tồn tại trong danh sách idUser
            if (idUserList.contains(userId)) {
              // Xóa userId khỏi danh sách idUser
              idUserList.remove(userId);
              totalDownload -= 1;
              // Cập nhật lại danh sách idUser mới trong tài liệu
              await doc.reference.update({'idUser': idUserList,'download': totalDownload});
            }
          }
        }
      }
    }
  }

  // add idUser
  Future<void> addIdUser(String id, String idUser) async {
    await _db.collection("statisticals").doc(id).update({
      "idUser": FieldValue.arrayUnion([idUser])
    });
  }

  // get a statis detail
  Future<List<StatisticalModel>> getStatistical() async {
    final list = <StatisticalModel>[];
    final snapshot = await _db.collection("statisticals").get();
    for (var docSnapshot in snapshot.docs) {
      final data = StatisticalModel.fromDocumentSnapshot(docSnapshot);
      list.add(data);
    }
    return list;
  }

  // get a statis detail
  Future<List<StatisticalModel>> getStatisticalByMostViews() async {
    final list = <StatisticalModel>[];
    final snapshot = await _db
        .collection("statisticals")
        .orderBy("view", descending: true) // Sắp xếp theo lượt xem giảm dần
        .limit(10) // Giới hạn kết quả trả về là 10
        .get();
    for (var docSnapshot in snapshot.docs) {
      final data = StatisticalModel.fromDocumentSnapshot(docSnapshot);
      list.add(data);
    }
    return list;
  }

  // get a statis detail
  Future<StatisticalModel> getDetailStatistical(String idMusic) async {
    final snapshot = await _db
        .collection("statisticals")
        .where("idMusic", isEqualTo: idMusic)
        .get();
    final data = snapshot.docs
        .map((e) => StatisticalModel.fromDocumentSnapshot(e))
        .single;
    return data;
  }

  // check statistical already axists
  Future<bool> checkStatistical(String idMusic) async {
    final snapshot = await _db
        .collection("statisticals")
        .where("idMusic", isEqualTo: idMusic)
        .get();
    if (snapshot.size != 0) {
      return true;
    }
    return false;
  }

  // check favourite
  Future<bool> checkFavouriteOrDownload(String idMusic, String idUser) {
    return _db
        .collection("statisticals")
        .where("idMusic", isEqualTo: idMusic)
        .where("idUser", arrayContains: idUser)
        .get()
        .then((snapshot) {
      if (snapshot.size != 0) {
        return true;
      } else {
        return false;
      }
    });
  }
}
