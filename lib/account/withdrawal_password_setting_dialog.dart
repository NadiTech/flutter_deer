
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';

class WithdrawalPasswordSettingDialog extends StatefulWidget {
  @override
  _WithdrawalPasswordSettingDialogState createState() => _WithdrawalPasswordSettingDialogState();
}

class _WithdrawalPasswordSettingDialogState extends State<WithdrawalPasswordSettingDialog> {
  
  var list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0];
  
  @override
  Widget build(BuildContext context) {
    _inputWidget.clear();
    for (int i = 0; i < 6; i++){
      _inputWidget.add(_buildInputWidget(i));
    }
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 6.5 / 10.0,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "设置提现密码",
                          style: TextStyles.textBoldDark18,
                        ),
                      ),
                      Positioned(
                        right: 16.0,
                        top: 16.0,
                        bottom: 16.0,
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 16.0,
                            width: 16.0,
                            child: Image.asset(Utils.getImgPath("goods/icon_dialog_close"))
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 45.0,
                    margin: const EdgeInsets.only(top: 28.0, left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.6, color: Colours.text_gray_c),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      children: _inputWidget,
                    ),
                  ),
                  Gaps.vGap10,
                  Text(("提现密码不可为连续、重复的数字。"), style: TextStyles.textGray12),
                  Expanded(child: Gaps.empty,),
                  Gaps.line,
                  Container(
                    color: Colours.line,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.953,
                        mainAxisSpacing: 0.6,
                        crossAxisSpacing: 0.6
                      ),
                      itemCount: 12,
                      itemBuilder: (_, index){
                        return Material(
                          color: (index == 9 || index == 11) ? Color(0xFFF2F2F2) : Colors.white,
                          child: InkWell(
                            child: Center(
                              child: (index == 9 || index == 11) ? Image.asset(index == 11 ? Utils.getImgPath("account/del") : "", width: 32.0,) :
                              Text(list[index].toString(), style: TextStyle(
                                  color: Colours.text_dark,
                                  fontSize: 26.0
                              )),
                            ),
                            onTap: (){
                              if(index == 9){
                                return;
                              }
                              if(index == 11){
                                if (_index == 0){
                                  return;
                                }
                                _codeList[_index - 1] = "";
                                _index--;
                                setState(() {

                                });
                                return;
                              }
                              _codeList[_index] = list[index].toString();
                              _index++;
                              if (_index == 6){

                                String code = "";
                                for (int i = 0; i < 6; i ++){
                                  code = code + _codeList[i];
                                }
                                Toast.show("密码：$code");
                                _index = 0;
                                for (int i = 0; i < 6; i ++){
                                  _codeList[i] = "";
                                }
                              }
                              setState(() {

                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
              ],
            )),
          )
        ],
      ),
    );
  }

  int _index = 0;
  List<Widget> _inputWidget = [];
  List<String> _codeList = ["", "", "", "", "", ""];

  Widget _buildInputWidget(int p){
    return Expanded(
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: p != 5 ? Border(
                right: Divider.createBorderSide(context, color: Colours.text_gray_c, width: 0.6),
              ) : null
          ),
          child: Text(_codeList[p].isEmpty ? "" : "●", style: TextStyles.textDark12,)
      ),
    );
  }
}
