import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_states.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import '../../../components/components.dart';
import '../../../shard/style/iconly_broken.dart';

class SearchUsers extends StatefulWidget {
  SearchUsers({Key? key}) : super(key: key);

  @override
  State<SearchUsers> createState() => _SearchState();
}

class _SearchState extends State<SearchUsers> {
  late List<UserModel> allUsers;

  late List<UserModel> searchedUsers;

  bool _isSearching = false;

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminStates>(
      builder: (context, state) {
        AdminCubit.get(context).getUsers();
        if (state is GitUsersDataSucsess) {
          allUsers = state.users;
          return buildSearchScreen();
        } else if (state is ChangeThemeSuccessState) {
          BlocProvider.of<AdminCubit>(context).getUsers();

          return buildSearchScreen();
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).progressIndicatorTheme.color,
          ));
        }
      },
    );
  }

  Widget buildSearchScreen() {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: buildCustomText(
                text: "إبحث عن مستخدم",
                style: Theme.of(context).textTheme.bodyLarge),
            centerTitle: true,
            iconTheme: Theme.of(context).iconTheme,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              buildSearchField(context),
              const SizedBox(
                height: 10,
              ),
              ConditionalBuilder(
                  condition: _isSearching && searchedUsers.isNotEmpty,
                  builder: (context) => Expanded(
                        child: SizedBox(
                          child: ListView.separated(
                              itemBuilder: ((context, index) => buildUserCard(
                                  context,
                                  model: searchedUsers[index])),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: searchedUsers.length),
                        ),
                      ),
                  fallback: (context) => buildSearchfallback())
            ],
          ),
        ));
  }

  Widget buildSearchfallback() {
    return Expanded(
      child: SizedBox(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      buildUserCard(context, model: allUsers[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: allUsers.length),
            )
          ],
        ),
      )),
    );
  }

  Widget buildSearchField(context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: defaultFormField(
        controller: searchController,
        type: TextInputType.text,
        onSubmit: (String text) {},
        hint: 'بحث ...',
        prefix: IconBroken.Search,
        context: context,
        suffixIcon: FontAwesomeIcons.xmark,
        validate: () {},
        onPressedsufix: () {
          clearSearching();
        },
        onChange: (searchedUser) {
          addSearchedItemToSearchedList(searchedUser);
        },
      ),
    );
  }

  void addSearchedItemToSearchedList(String searchedUser) {
    if (searchedUser.isNotEmpty) {
      searchedUsers =
          allUsers.where((user) => user.name.startsWith(searchedUser)).toList();
      setState(() {
        _isSearching = true;
        searchedUsers.forEach((element) {
          print(element.name);
        });
        print("this is searching");
        print(searchedUsers.length);
        print("this is searching");
      });
    } else {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void clearSearching() {
    setState(() {
      searchController.clear();
      searchedUsers.clear();
    });
  }
}

Widget buildUserCard(context, {required UserModel model}) => Column(
      children: [
        Container(
          width: double.infinity,
          height: 115,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
            color: ThemeCubit.get(context).darkTheme
                ? mainColors
                : containerFollowStudent,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    if (model.image != null)
                      CircleAvatar(
                        radius: 25.0,
                        backgroundColor: ThemeCubit.get(context).darkTheme
                            ? mainTextColor
                            : mainColors,
                        backgroundImage: NetworkImage(model.image!),
                      ),
                    if (model.image == null)
                      CircleAvatar(
                        radius: 25.0,
                        backgroundColor: ThemeCubit.get(context).darkTheme
                            ? mainTextColor
                            : mainColors,
                        child: Container(
                          alignment: Alignment.center,
                          height: 80.0,
                          child: Icon(
                            Icons.error,
                            color: ThemeCubit.get(context).darkTheme
                                ? mainColors
                                : mainTextColor,
                          ),
                        ),
                      ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.name,
                            style: Theme.of(context).textTheme.bodyText2),
                        Text('${model.email}',
                            style: Theme.of(context).textTheme.bodyText2),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              defaultButton2(
                function: () {
                  // navigateTo(context, EnterStudentDetailsScreen(item: model,));
                },
                text: 'حذف المستخدم ',
                width: double.infinity,
                height: 32.0,
                btnColor: Colors.red,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
