import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_state_management/bloc/items_bloc.dart';

class ItemsView extends StatefulWidget {
  const ItemsView({super.key});

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  @override
  void initState() {
     SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    context.read<ItemsBloc>().add(ItemsLoadedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Items List",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          if (state is ItemsLoadingState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is ItemsLoadedState) {
            return ListView.builder(
                itemCount: state.itemsList.length,
                itemBuilder: (context, index) {
                  var iObj = state.itemsList[index];
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 2)
                          ]),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl:  iObj.image ?? "",
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            width: 70,
                            height: 70,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                iObj.title ?? "",
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                iObj.category.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ))
                        ],
                      ));
                });
          } else if (state is ItemsErrorState) {
            return Center(child: Text(state.errorMSG));
          }
          return Container();
        },
      ),
    );
  }
}
