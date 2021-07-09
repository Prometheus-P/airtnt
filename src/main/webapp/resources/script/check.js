//[회원가입 유효성검사]
function checkAll() {
        if (!checkUserId(form.userId.value)) {
            return false;
        } else if (!checkPassword(form.userId.value, form.password1.value, form.password2.value)) {
            return false;
        } else if (!checkName(form.name.value)) {
            return false;
        } else if (!checkEmail(form.eamil.value)) {
            return false;
        }
        
        return true;
    }

//공백확인 함수
function checkExistData(value, dataName) {
    if (value == "") {
        alert(dataName + " 입력해주세요!");
        return false;
    }
    return true;
}

function checkUserId(id) {
    //Id가 입력되었는지 확인하기
    if (!checkExistData(id, "아이디를"))
        return false;

    var idRegExp = /^[a-zA-z0-9]{4,20}$/; //아이디 유효성 검사
    if (!idRegExp.test(id)) {
        alert("아이디는 영문 대소문자와 숫자 4~20자리로 입력해야합니다!");
        form.userId.value = "";
        form.userId.focus();
        return false;
    }
    return true; //확인이 완료되었을 때
}

function checkPassword(id, password1, password2) {
    //비밀번호가 입력되었는지 확인하기
    if (!checkExistData(password1, "비밀번호를"))
        return false;
    //비밀번호 확인이 입력되었는지 확인하기
    if (!checkExistData(password2, "비밀번호 확인을"))
        return false;

    var password1RegExp = /^[a-zA-z0-9]{4,20}$/; //비밀번호 유효성 검사
    if (!password1RegExp.test(password1)) {
        alert("비밀번호는 영문 대소문자와 숫자 4~20자리로 입력해야합니다!");
        form.password1.value = "";
        form.password1.focus();
        return false;
    }
    //비밀번호와 비밀번호 확인이 맞지 않다면..
    if (password1 != password2) {
        alert("두 비밀번호가 맞지 않습니다.");
        form.password1.value = "";
        form.password2.value = "";
        form.password2.focus();
        return false;
    }

    //아이디와 비밀번호가 같을 때..
    if (id == password1) {
        alert("아이디와 비밀번호는 같을 수 없습니다!");
        form.password1.value = "";
        form.password2.value = "";
        form.password2.focus();
        return false;
    }
    return true; //확인이 완료되었을 때
}

function checkName(name) {
    if (!checkExistData(name, "이름을"))
        return false;

    var nameRegExp = /^[가-힣a-zA-z]{2,50}$/;
    if (!nameRegExp.test(name)) {
        alert("이름이 올바르지 않습니다.");
        return false;
    }
    return true; //확인이 완료되었을 때
}

function checkEmail(eamil) {
    if (!checkExistData(eamil, "이메일을"))
        return false;

    var eamilRegExp =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    if (!eamilRegExp.test(eamil)) {
        alert("이메일이 올바르지 않습니다.");
        return false;
    }
    return true; //확인이 완료되었을 때
}

//[비밀번호 변경 유효성검]
function PcheckAll() {
    if (!PcheckExist()) {
        return;
    } else if (!PcheckSame(edit.CurrentPass.value, edit.NewPass.value, edit.ConfirmPass.value)) {
        return;
    }
    document.edit.submit();
}

function PcheckExist(){
	if (edit.CurrentPass.value==""){
		alert("현재 비밀번호를 입력하세요")
		return false;
	}
	if (edit.NewPass.value==""){
		alert("새 비밀번호를 입력하세요")
		return false;
	}
	if (edit.ConfirmPass.value==""){
		alert("비밀번호확인을 입력하세요")
		return false;
	}
	return true;
}

function PcheckSame(CurrentPass, NewPass, ConfirmPass){
	 var password1RegExp = /^[a-zA-z0-9]{4,20}$/; //비밀번호 유효성 검사
        if (!password1RegExp.test(NewPass)) {
            alert("비밀번호는 영문 대소문자와 숫자 4~20자리로 입력해야합니다!");
            edit.NewPass.value = "";
            edit.NewPass.focus();
            return false;
        }
        if (CurrentPass == NewPass) {
            alert("현재 비밀번호와 새 비밀번호가 같습니다");
            edit.NewPass.value = "";
            edit.NewPass.focus();
            return false;
        }
        if (NewPass != ConfirmPass) {
            alert("두 비밀번호가 맞지 않습니다.");
            edit.NewPass.value = "";
            edit.ConfirmPass.value = "";
            edit.ConfirmPass.focus();
            return false;
        }
        return true; 
}

//[비밀번호 확인]
function samePass() {
	var Npass = document.getElementById('NewPass').value;
	var Cpass = document.getElementById('ConfirmPass').value;
	
	if(Npass==Cpass){
		document.getElementById('same').innerHTML="비밀번호가 일치합니다";
		document.getElementById('same').style.color="blue";
	}
	if(Npass!=Cpass){
		document.getElementById('same').innerHTML="비밀번호가 불일치합니다";
		document.getElementById('same').style.color="red";
	}
	if(Npass=="" || Cpass==""){
		document.getElementById('same').innerHTML="";
	}
	
}

//[프로필 변경 유효성 검사]
function profileEditCheck(){
	if (!PcheckName(profileEdit.Pname.value)) {
        return false;
    }
	if (!PcheckEmail(profileEdit.Pemail.value)) {
        return false;
    }
    return true;
}
function PcheckName(name) {
    if (!checkExistData(name, "이름을"))
        return false;

    var nameRegExp = /^[가-힣a-zA-z]{2,50}$/;
    if (!nameRegExp.test(name)) {
        alert("이름이 올바르지 않습니다.");
        return false;
    }
    return true; //확인이 완료되었을 때
}

function PcheckEmail(eamil) {
    if (!checkExistData(eamil, "이메일을"))
        return false;

    var eamilRegExp =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    if (!eamilRegExp.test(eamil)) {
        alert("이메일이 올바르지 않습니다.");
        return false;
    }
    return true; //확인이 완료되었을 때
}
//수정돼야 submit으로 바뀌게
function checkChange() {
	profileEdit.sButton.type="submit"
}

//[아이디 비밀번호 찾기 유효성 검사]
function FindPassCheck(){
	if (findPass.Fid.value==""){
		alert("ID를 입력하세요")
		findPass.Fid.focus();
		return false;
	}
	if (findPass.Fname.value==""){
		alert("이름를 입력하세요")
		findPass.Fname.focus();
		return false;
	}
	if (findPass.Femail.value==""){
		alert("메일을 입력하세요")
		findPass.Femail.focus();
		return false;
	}
	return true;
}
function FindIdCheck(){
	if (findId.FIname.value==""){
		alert("이름를 입력하세요")
		findId.FIname.focus();
		return false;
	}
	if (findId.FIemail.value==""){
		alert("메일을 입력하세요")
		findId.FIemail.focus();
		return false;
	}
	return true;
}

//[회원탈퇴 컨펌]
function sure(){
	var input = confirm('정말로 탈퇴하시겠습니까?');

    if(input) {
    	window.location.href='/myPage/deleteMember';
    } else {
    	return
    }
}
