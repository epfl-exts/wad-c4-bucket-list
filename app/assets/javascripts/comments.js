Comments = {
  displayComment: function(comment) {
    var commentTime = document.createElement('time');
    commentTime.setAttribute('datetime', '2017-11-28T13:48');
    commentTime.appendChild(document.createTextNode(comment.timeInWords));

    var commentHeader = document.createElement('h3');
    commentHeader.className = 'comment__title';
    commentHeader.appendChild(document.createTextNode(comment.userName));
    commentHeader.appendChild(commentTime);

    var commentParagraph = document.createElement('p');
    commentParagraph.appendChild(document.createTextNode(comment.body));

    var commentBody = document.createElement('div');
    commentBody.className = 'comment__body';
    commentBody.appendChild(commentHeader);
    commentBody.appendChild(commentParagraph);

    var avatar = document.createElement('img');
    avatar.className = 'avatar';
    avatar.setAttribute('src', '#images/avatar.png');

    var commentListItem = document.createElement('li');
    commentListItem.className = 'comment';
    commentListItem.appendChild(avatar);
    commentListItem.appendChild(commentBody);

    var comments = document.getElementById('commentList');
    comments.insertBefore(commentListItem, comments.firstChild);
  }
};
