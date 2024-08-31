import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class FirestoreServices{
  static saveUser(String name,lastname , email , contact , uid) async{
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(uid)
        .set({'email' : email , 'FirstName' : name , 'LastName' : lastname , 'contact' : contact , 'uid' : uid});
  }
}
class FirestoreServices2{
  static booking(String u_fname , u_lname ,u_email ,  u_contact , u_flat ,u_uid, u_landmark , u_state ,date , time, w_image , work , w_name ,w_uid,w_email, w_contact , w_approval , cost , payment_sts , work_sts , text , worker_uuid , booking_no , work_type , work_opted) async{
    String id = randomAlphaNumeric(5);

    await FirebaseFirestore.instance
        .collection('Booking')
        .doc(id)
        .set({
              'UserFname' : u_fname,
              'UserLname' : u_lname,
              'User_Contact' : u_contact,
              'User_flat' : u_flat,
              'User_Landmark' : u_landmark,
              'User_state' : u_state,
              'User_uid' : u_uid,
              'User_email' : u_email,
              'booking_date':date,
              'booking_time':time,
              'Worker_image':w_image,
              'Work' : work,
              'Worker_name':w_name,
              'Worker_email' : w_email,
              'Worker_contact':w_contact,
              'Worker_uid' : w_uid,
              'Worker_approval_sts':w_approval,
              'Cost' : cost,
              'Payment_sts':payment_sts,
              'Work_sts' : work_sts,
              'bookingId' : id,
              'DBName' : text,
              'WorkerUID' : worker_uuid,
              'Booking_No' : booking_no,
              'Work_type' : work_type,
              'Work_opted' : work_opted
         });
  }

}