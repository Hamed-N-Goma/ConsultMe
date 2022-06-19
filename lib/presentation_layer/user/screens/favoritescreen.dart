import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:consultme/models/favoriteModel.dart';
import 'package:consultme/presentation_layer/user/widget/favoriteItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ConsultantModel> consultant =
        BlocProvider.of<UserLayoutCubit>(context).conslutants;

    return Scaffold(
      appBar: AppBar(
        title: buildCustomText(
          text: 'المفضلة',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      body: BlocBuilder<UserLayoutCubit, UserLayoutState>(
        builder: (context, state) {
          if (state is DeleteFromFavSucsses) {
            BlocProvider.of<UserLayoutCubit>(context).getFavorite();
            List<FavoriteModel> favorite =
                BlocProvider.of<UserLayoutCubit>(context).favoriteList;
            return ListView.separated(
                itemBuilder: (context, index) => FavoriteItem(
                    consultant: consultant[index], favoriteUid: favorite),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: consultant.length);
          } else {
            List<FavoriteModel> favorite =
                BlocProvider.of<UserLayoutCubit>(context).favoriteList;
            return ListView.separated(
                itemBuilder: (context, index) => FavoriteItem(
                    consultant: consultant[index], favoriteUid: favorite),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: consultant.length);
          }
        },
      ),
    );
  }
}
