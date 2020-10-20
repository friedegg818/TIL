package com.sp.guest;

import java.util.List;
import java.util.Map;

public interface GuestService {
	public void insertGuest(Guest dto) throws Exception;
	public int dataCount();
	public List<Guest> listGuest(Map<String, Object> map);
	public void deleteGuest(int num) throws Exception;
}
