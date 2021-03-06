package com.moida.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.moida.web.entity.PostsContent;

public interface PostsContentDao {
	public int insert(PostsContent postsContent);	
	public List<PostsContent> getPostsContent(Integer postsId); 
	public int delete(int postsId);
}
