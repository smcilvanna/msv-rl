function rewardTable = sortReward(allData)
    rewardTable =[];
    for i = 1:size(allData,1)
        rewards = allData(i).reward.Data;
        reward = sum(rewards);
        rewardTable = [rewardTable ; [i, reward] ];
        rewardTable = sortrows(rewardTable,2,"descend");
    end
end

