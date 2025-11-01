package com.jobmate.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.jobmate.mapper.FavoriteMapper;

@Service
public class FavoriteService {

    @Autowired
    private FavoriteMapper favoriteMapper;

    public boolean isFavorite(Long memberId, String source, String empSeqno) {
        return favoriteMapper.checkFavorite(memberId, source, empSeqno);
    }

    public void addFavorite(Long memberId, String source, String empSeqno,
                            String title, String company, String deadline) {
        favoriteMapper.addFavorite(memberId, source, empSeqno, title, company, deadline);
    }

    public void removeFavorite(Long memberId, String source, String empSeqno) {
        favoriteMapper.removeFavorite(memberId, source, empSeqno);
    }

    public int getFavoriteCount(Long memberId) {
        return favoriteMapper.countFavorites(memberId);
    }

    public List<Map<String, Object>> getFavoriteList(Long memberId) {
        return favoriteMapper.getFavorites(memberId);
    }
}
