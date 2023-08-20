import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_state_management/cubit/user_cubit.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<UserCubit>().dataLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body:

          BlocConsumer<UserCubit, UserState>(builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is UserLoadedState) {
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  itemCount: state.userObj.users?.length ?? 0,
                  itemBuilder: (context, index) {
                    var userObj = state.userObj.users?[index];
                    return userObj != null
                        ? Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black12, blurRadius: 2)
                                ]),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: CachedNetworkImage(
                                    imageUrl: userObj.image ?? "",
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${userObj.firstName} ${userObj.lastName}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${userObj.email}",
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container();
                  });
            } else if (state is UserErrorState) {
              return Center(
                child: Text(state.errorMSG),
              );
            }
            return Container();
          }, listener: (context, state) {
            // TODO: implement listener
            if (state is UserLoadedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("user data loaded successfully")));
            } else if (state is UserErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMSG)));
            }
          }),

      //     BlocListener<UserCubit, UserState>(
      //   listener: (context, state) {
      //     // TODO: implement listener
      //     if (state is UserLoadedState) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //           const SnackBar(content: Text("user data loaded successfully")));
      //     } else if (state is UserErrorState) {
      //       ScaffoldMessenger.of(context)
      //           .showSnackBar(SnackBar(content: Text(state.errorMSG)));
      //     }
      //   },
      //   child: BlocBuilder<UserCubit, UserState>(
      //     builder: (context, state) {
      //       if (state is UserLoadingState) {
      //         return const Center(child: CircularProgressIndicator.adaptive());
      //       } else if (state is UserLoadedState) {
      //         return ListView.builder(
      //             padding:
      //                 const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      //             itemCount: state.userObj.users?.length ?? 0,
      //             itemBuilder: (context, index) {
      //               var userObj = state.userObj.users?[index];
      //               return userObj != null
      //                   ? Container(
      //                       margin: const EdgeInsets.symmetric(vertical: 4),
      //                       padding: const EdgeInsets.all(15),
      //                       decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(5),
      //                           boxShadow: const [
      //                             BoxShadow(
      //                                 color: Colors.black12, blurRadius: 2)
      //                           ]),
      //                       child: Row(
      //                         children: [
      //                           ClipRRect(
      //                             borderRadius: BorderRadius.circular(35),
      //                             child: CachedNetworkImage(
      //                               imageUrl: userObj.image ?? "",
      //                               placeholder: (context, url) => const Center(
      //                                   child: CircularProgressIndicator()),
      //                               width: 70,
      //                               height: 70,
      //                             ),
      //                           ),
      //                           const SizedBox(
      //                             width: 15,
      //                           ),
      //                           Expanded(
      //                             child: Column(
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               children: [
      //                                 Text(
      //                                   "${userObj.firstName} ${userObj.lastName}",
      //                                   style: const TextStyle(
      //                                       fontWeight: FontWeight.bold),
      //                                 ),
      //                                 Text(
      //                                   "${userObj.email}",
      //                                   style: const TextStyle(fontSize: 15),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     )
      //                   : Container();
      //             });
      //       } else if (state is UserErrorState) {
      //         return Center(
      //           child: Text(state.errorMSG),
      //         );
      //       }
      //       return Container();
      //     },
      //   ),
      // ),
    );
  }
}
