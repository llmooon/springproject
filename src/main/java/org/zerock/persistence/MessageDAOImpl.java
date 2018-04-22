package org.zerock.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.MessageVO;

@Repository
public class MessageDAOImpl implements MessageDAO {

	@Inject
	private SqlSession session;
	private static String namespace = "org.zerock.mapper.messageMapper";
	
	@Override
	public void create(MessageVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".create",vo);
	}

	@Override
	public MessageVO readMessage(Integer mid) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".readMessage",mid);
	}

	@Override
	public void updateState(Integer mid) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+"updateState", mid);
	}

}
