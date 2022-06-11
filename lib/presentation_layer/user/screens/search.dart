import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/presentation_layer/user/widget/toprated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:consultme/models/consultantmodel.dart';

import '../../../Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import '../../../components/components.dart';
import '../../../shard/style/iconly_broken.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late List<ConsultantModel> allConsultants;

  late List<ConsultantModel> searchedConsultant;

  bool _isSearching = false;

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLayoutCubit, UserLayoutState>(
      builder: (context, state) {
        if (state is GitConsultantsDataSucsess) {
          allConsultants = state.consultants;
          return buildSearchScreen();
        } else if (state is ChangeThemeSuccessState) {
          BlocProvider.of<UserLayoutCubit>(context).getConsultants();

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
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          buildSearchField(context),
          const SizedBox(
            height: 10,
          ),
          ConditionalBuilder(
              condition: _isSearching && searchedConsultant.isNotEmpty,
              builder: (context) => Expanded(
                    child: SizedBox(
                      child: ListView.separated(
                          itemBuilder: ((context, index) =>
                              Toprated(consultant: searchedConsultant[index])),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: searchedConsultant.length),
                    ),
                  ),
              fallback: (context) => buildSearchfallback())
        ],
      ),
    );
  }

  Widget buildSearchfallback() {
    return Expanded(
      child: SizedBox(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconBroken.Search,
              color: Colors.grey[400],
              size: 150,
            ),
            Text(
              'إبحث عن مستشار',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      )),
    );
  }

  Widget buildSearchField(context) {
    return defaultFormField(
        label: 'بحث ',
        controller: searchController,
        type: TextInputType.name,
        validate: () {},
        prefix: IconBroken.Search,
        context: context,
        suffixIcon: FontAwesomeIcons.xmark,
        isClickable: true,
        onPressedsufix: () {
          clearSearching();
        },
        onChange: (searchedCon) {
          addSearchedItemToSearchedList(searchedCon);
        });
  }

  void addSearchedItemToSearchedList(String searchConsultant) {
    if (searchConsultant.isNotEmpty) {
      searchedConsultant = allConsultants
          .where((consultant) => consultant.name!.startsWith(searchConsultant))
          .toList();
      setState(() {
        _isSearching = true;
        searchedConsultant.forEach((element) {
          print(element.name);
        });
        print("this is searching");
        print(searchedConsultant.length);
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
      searchedConsultant.clear();
    });
  }
}
