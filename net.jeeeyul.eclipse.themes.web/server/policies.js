Meteor.startup(function() {
	Comments.allow({
		insert : function(userId, content) {
			return userId != null;
		}
	});

	EPFs.allow({
		insert : function(userId, content) {
			return userId != null;
		}
	});
});