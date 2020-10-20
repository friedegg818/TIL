package com.sp.blog;

import java.util.List;

public interface BlogService {
	public List<Blog> listBlog();
	public Blog readBlog(long idx);
}
