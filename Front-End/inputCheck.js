function writeCheck() {
   var form = document.writeform;


   if (!form.title.value) {
      alert("제목을 적어주세요");
      form.title.focus();
      return;
   }

   if (!form.name.value) {
      alert("이름을 적어주세요");
      form.name.focus();
      return;
   }

   if (!form.password.value) {
      alert("비밀번호를 적어주세요");
      form.password.focus();
      return;
   }
   
   if (!form.memo.value) {
      alert("내용을 적어주세요");
      form.memo.focus();
      return;
   }

   form.submit();
}

function writeReplyCheck() {
   var form = document.writeform;

   if (!form.name.value) {
      alert("이름을 적어주세요");
      form.name.focus();
      return;
   }

   if (!form.memo.value) {
      alert("내용을 적어주세요");
      form.memo.focus();
      return;
   }

   form.submit();
}