import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../users_profile/model/user_model.dart';

class MyOrders extends StatefulWidget {
  ProfileModel user;
  MyOrders({Key? key, required this.user}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    super.initState();
    executeFunctionBasedOnRole();
  }

  void executeFunctionBasedOnRole() {
    if (widget.user.role == 'Brand') {
      handleBrandFunction();
    } else if (widget.user.role == 'Influencer') {
      handleInfluencerFunction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
