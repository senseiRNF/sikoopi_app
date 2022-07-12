import 'package:flutter/material.dart';
import 'package:sikoopi_app/miscellaneous/functions/global_route.dart';

class GlobalDialog {
  final BuildContext context;
  final String message;

  const GlobalDialog({
    required this.context,
    required this.message,
  });

  void okDialog(Function callback) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Attention',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  message,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                GlobalRoute(context: context).back(null);
              },
              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    ).then((_) {
      callback();
    });
  }

  void optionDialog(Function yes, Function no) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Attention',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  message,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                GlobalRoute(context: context).back(false);
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                GlobalRoute(context: context).back(true);
              },
              child: const Text(
                'Yes',
              ),
            ),
          ],
        );
      },
    ).then((result) {
      if(result != null) {
        if(result) {
          yes();
        } else {
          no();
        }
      }
    });
  }

  void listCategory(List<String> listCategory, Function onSelect) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Select Category',
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listCategory.length,
                  itemBuilder: (BuildContext listContext, int index) {
                    return ListTile(
                      onTap: () {
                        GlobalRoute(context: context).back(
                          listCategory[index],
                        );
                      },
                      title: Text(
                        listCategory[index],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    ).then((dynamic dialogResult){
      if(dialogResult != null) {
        onSelect(dialogResult);
      }
    });
  }

  void listProductMenu(List<String> listProductMenu, Function onSelect) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Select Menu',
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listProductMenu.length,
                  itemBuilder: (BuildContext listContext, int index) {
                    return ListTile(
                      onTap: () {
                        GlobalRoute(context: context).back(
                          listProductMenu[index],
                        );
                      },
                      title: Text(
                        listProductMenu[index],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    ).then((dynamic dialogResult){
      if(dialogResult != null) {
        onSelect(dialogResult);
      }
    });
  }
}