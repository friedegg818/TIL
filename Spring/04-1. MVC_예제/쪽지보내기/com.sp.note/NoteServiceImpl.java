package com.sp.note;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

@Service("note.noteService")
public class NoteServiceImpl implements NoteService {

	@Override
	public List<Note> listFriend() {
		List<Note> list = new ArrayList<>();
		
		Note dto; 
		dto = new Note(); dto.setUserId("lee"); dto.setUserName("이이이");
		list.add(dto);
		dto = new Note(); dto.setUserId("kim"); dto.setUserName("김김김");
		list.add(dto);
		dto = new Note(); dto.setUserId("na"); dto.setUserName("나나나");
		list.add(dto);
		dto = new Note(); dto.setUserId("mi"); dto.setUserName("미미미");
		list.add(dto);
		dto = new Note(); dto.setUserId("ko"); dto.setUserName("고고고");
		list.add(dto);
		dto = new Note(); dto.setUserId("gg"); dto.setUserName("지지지");
		list.add(dto);
		dto = new Note(); dto.setUserId("ho"); dto.setUserName("호호호");
		list.add(dto);		
		
		return list;
	}

}
