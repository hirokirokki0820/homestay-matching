// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
// import jquery from "jquery"
// window.$ = window.jQuery = jquery
window.bootstrap = require("bootstrap")


  // document.addEventListener("DOMContentLoaded", () => {
//   document.addEventListener("turbo:load", ()=>{

//   // フォーム全体の要素
//     const userForm = document.querySelector("#userForm");

//     // 各入力フィールド(name, email, password, password_confirmation) の要素
//     const userNameField = document.querySelector('#userName');
//     const userEmailField = document.querySelector('#userEmail');
//     const userPasswordField = document.querySelector('#userPassword');
//     const userPasswordConfirmationField = document.querySelector('#userPasswordConfirmation');

//     // パスワードおよびパスワード確認用フィールドの要素グループ
//     const userPasswordGroup = document.querySelector('#userPasswordGroup');

//     // 各入力フィールド内の <input> タグ
//     const userName = document.querySelector("#user_name");
//     const userEmail = document.querySelector("#user_email");
//     const userPassword = document.querySelector("#user_password");
//     const userPasswordConfirmation = document.querySelector("#user_password_confirmation");

//     // 各フィールドのエラーメッセージ表示用の paragraph
//     const namePara = document.createElement('p');
//     const emailPara = document.createElement('p');
//     const passwordPara = document.createElement('p');
//     const confirmationPara = document.createElement('p');

//     // 各入力フィールドのバリデーションチェック用の変数
//     // エラー時は"false", OK時は"true"を代入する（後述）
//     let activeName;
//     let activeEmail;
//     let activePassword;

//     // email の正規表現パターン↓
//     const emailRegex = /^[a-zA-Z0-9_+-]+(\.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$/;
//     const passwordRegex = /^([a-zA-Z0-9]{6,})$/; // 半角英数字6文字以上を表す正規表現



//   // document.addEventListener("turbo:load", ()=>{

//   // フォーム送信ボタン（Submit）の要素
//   var userSubmitBtn = document.querySelector('#userSubmit');
//   // Submitボタンの有効化条件

//   userSubmitBtn.disabled = true; // デフォルトでSubmitボタンを無効化
//   userForm.addEventListener('input', ()=>{
//     if(activeName === true && activeEmail === true && activePassword === true){
//       userSubmitBtn.disabled = false;
//     }else{
//       userSubmitBtn.disabled = true;
//     }
//    });

//   //表示名(:name)のバリデーション
//   userName.addEventListener('input', ()=>{
//     if(userName.value === ""){ // 入力フォームが空の場合
//       namePara.textContent = "表示名を入力してください";
//       namePara.style.color = "red";
//       userName.parentElement.style.border = "2px solid red";
//       activeName = false;
//     }else if(userName.value.length < 3){ // 文字数が3文字未満の場合
//       namePara.textContent = "表示名は３文字以上で入力してください";
//       namePara.style.color = "red";
//       userName.parentElement.style.border = "2px solid red";
//       activeName = false;
//     }else if(userName.value.length > 50){ // 文字数が50文字以上の場合
//       namePara.textContent = "表示名は50文字以内で入力してください";
//       namePara.style.color = "red";
//       userName.parentElement.style.border = "2px solid red";
//       userSubmitActive -= 1;
//       activeName = false;
//     }else{ // バリデーションチェック完了時（OK時）の処理
//       userName.parentElement.style.border = "2px solid lightgreen";
//       namePara.textContent = "";
//       activeName = true;
//     }
//     userNameField.appendChild(namePara); // :name用のバリデーションエラーメッセージを表示
//   });

//   //メールアドレス(:email)のバリデーション
//   userEmail.addEventListener('input', ()=>{
//     if(userEmail.value === ""){ // 入力フォームが空の場合
//       emailPara.textContent = "メールアドレスを入力してください";
//       emailPara.style.color = "red";
//       userEmail.parentElement.style.border = "2px solid red";
//       activeEmail = false;
//     }else if(!emailRegex.test(userEmail.value)){ // 入力した値がemailRegexの正規表現パターンにマッチしない場合
//       emailPara.textContent = "有効なアドレスを入力してください";
//       emailPara.style.color = "red";
//       userEmail.parentElement.style.border = "2px solid red";
//       activeEmail = false;
//     }else{ // バリデーションチェック完了時（OK時）の処理
//       userEmail.parentElement.style.border = "2px solid lightgreen";
//       emailPara.textContent = "";
//       activeEmail = true;
//     }
//     userEmailField.appendChild(emailPara); // :email用のバリデーションエラーメッセージを表示
//   });

//   //パスワード(:password, :password_confirmation)のバリデーション
//   userPasswordGroup.addEventListener('input', ()=>{

//     // パスワード(:password)がpasswordRegexの正規表現パターンに一致しない時の処理
//     if(!passwordRegex.test(userPassword.value)){
//       if(userPassword.value === ""){ // 入力フォーム(userPassword)が空の場合
//         confirmationPara.textContent = "";
//         passwordPara.textContent = "パスワードを入力してください";
//         passwordPara.style.color = "red";
//         userPassword.parentElement.style.border = "2px solid red";
//         activePassword = false;
//       }else{ // 入力した値が1文字以上6文字未満である場合
//         confirmationPara.textContent = "";
//         passwordPara.textContent = "6文字以上の半角英数字を入力してください";
//         passwordPara.style.color = "red";
//         userPassword.parentElement.style.border = "2px solid red";
//         userPasswordConfirmation.parentElement.style.border = "none";
//         activePassword = false;
//       }
//     }
//     // パスワード(:password)がpasswordRegexの正規表現パターンに一致した時の処理
//     else{
//       if(userPasswordConfirmation.value === ""){ // 入力フォーム(userPasswordConfirmation)が空の場合
//         passwordPara.textContent = "";
//         confirmationPara.textContent = "パスワード(確認用)を入力してください";
//         confirmationPara.style.color = "red";
//         userPassword.parentElement.style.border = "2px solid lightgreen";
//         userPasswordConfirmation.parentElement.style.border = "2px solid red";
//         activePassword = false;
//       }else if(userPasswordConfirmation.value === userPassword.value){ // パスワード、パスワード確認用の値が一致する場合
//         passwordPara.textContent = "";
//         confirmationPara.textContent = "";
//         userPassword.parentElement.style.border = "2px solid lightgreen";
//         userPasswordConfirmation.parentElement.style.border = "2px solid lightgreen";
//         activePassword = true;
//       }else{ // パスワード、パスワード確認用の値が一致しない場合
//         passwordPara.textContent = "";
//         confirmationPara.textContent = "入力したパスワードと一致しません";
//         confirmationPara.style.color = "red";
//         userPassword.parentElement.style.border = "2px solid lightgreen";
//         userPasswordConfirmation.parentElement.style.border = "2px solid red";
//         activePassword = false;
//       }
//     }

//     userPasswordField.appendChild(passwordPara); // :password用のバリデーションエラーメッセージを表示
//     userPasswordConfirmationField.appendChild(confirmationPara); // :password_confirmation用のバリデーションエラーメッセージを表示
//   });

// });
