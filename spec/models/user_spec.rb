require 'rails_helper'

RSpec.describe User, type: :model do

  describe "scopes" do
    before :context do

      create :default_config, default_ranking: 1400
      @game = create :wesnoth
      @ladder = create :wesnoth_ladder, game: @game
      @blitz_ladder = create :wesnoth_blitz_ladder, game: @game

      @u_sa = User.create!(email: "auuh@sadmin.com", password: "asdqwezxc1123")
      @u_vsa = User.create!(email: "buuh@vsadmin.com", password: "1asdqwezxc1123")
      @u_a1 = User.create!(email: "cuuh@admin.com", password: "2asdqwezxc1123")
      @u_a2 = User.create!(email: "duuh@admin.com", password: "3asdqwezxc1123")
      @u_a3 = User.create!(email: "euuh@admin.com", password: "4asdqwezxc1123")
      @u_va1 = User.create!(email: "fuuh@vadmin.com", password: "5asdqwezxc1123")
      @u_va2 = User.create!(email: "guuh@vadmin.com", password: "6asdqwezxc1123")
      @u_va3 = User.create!(email: "huuh@vadmin.com", password: "7asdqwezxc1123")
      @u_va4 = User.create!(email: "iuuh@vadmin.com", password: "8asdqwezxc1123")
      @u_gm1 = User.create!(email: "juuh@gmod.com", password: "9asdqwezxc1123")
      @u_gm2 = User.create!(email: "kuuh@gmod.com", password: "0asdqwezxc1123")
      @u_gm3 = User.create!(email: "luuh@gmod.com", password: "aasdqwezxc1123")

      @u_ge1 = User.create!(email: "auuh@ge.com", password: "a1qwezxc1123")
      @u_ge2 = User.create!(email: "buuh@ge.com", password: "aasd22c1123")
      @u_re1 = User.create!(email: "cuuh@re.com", password: "aas33c1123")
      @u_re2 = User.create!(email: "duuh@re.com", password: "aasd44c1123")

      @u_t1 = User.create!(email: "muuh@user.com", password: "sasdqwezxc1123")
      @u_t2 = User.create!(email: "nuuh@user.com", password: "dasdqwezxc1123")
      @u1 = User.create!(email: "ouuh@user.com", password: "fasdqwezxc1123")
      @u2 = User.create!(email: "puuh@user.com", password: "gasdqwezxc1123")
      @u_n1 = User.create!(email: "quuh@user.com", password: "hasdqwezxc1123")
      @u_n2 = User.create!(email: "ruuh@user.com", password: "jdqwezxc1123")
      @u_bl1 = User.create!(email: "suuh@user.com", password: "kasdqweds1123")
      @u_bl2 = User.create!(email: "tuuh@user.com", password: "kasdqweec1123")
      @u_ba1 = User.create!(email: "uuuh@user.com", password: "kasd2344ezxc1123")
      @u_ba2 = User.create!(email: "vuuh@user.com", password: "kasdqwfv3xc1123")
      @u_e1 = User.create!(email: "wuuh@user.com", password: "ka3xc1123")
      @u_e2 = User.create!(email: "yuuh@user.com", password: "kasgghzxc1123")

      @u_sa.add_role :super_admin
      @u_vsa.add_role :vice_super_admin
      @u_a1.add_role :admin
      @u_a2.add_role :admin
      @u_a3.add_role :admin
      @u_va1.add_role :vice_admin
      @u_va2.add_role :vice_admin
      @u_va3.add_role :vice_admin
      @u_va4.add_role :vice_admin
      @u_gm1.add_role :global_moderator
      @u_gm2.add_role :global_moderator
      @u_gm3.add_role :global_moderator

      @u_ge1.add_role(:game_editor, @game)
      @u_ge2.add_role(:game_editor, @game)
      @u_re1.add_role(:ranking_editor, @ladder)
      @u_re2.add_role(:ranking_editor, @blitz_ladder)

      @u_t1.add_role :trusted_user
      @u_t2.add_role :trusted_user
      @u2.add_role :user
      @u1.add_role :user
      @u_n1.add_role :new_user
      @u_n2.add_role :new_user
      @u_bl1.add_role :blocked_user
      @u_bl2.add_role :blocked_user
      @u_ba1.add_role :banned_user
      @u_ba2.add_role :banned_user
      @u_e1.add_role :evaporated_user
      @u_e2.add_role :evaporated_user
    end

    after :context do
      User.destroy_all
      Ladder.destroy_all
      Game.destroy_all
      LadderConfig.destroy_all
    end

    it "can scope super_admins" do
      expect(User.super_admins).to match_array [@u_sa]
    end

    it "can scope vice_super_admins" do
      expect(User.vice_super_admins).to match_array [@u_vsa]
    end

    it "can scope admins" do
      expect(User.admins).to match_array [@u_a2, @u_a1, @u_a3]
    end

    it "can scope vice_admins" do
      expect(User.vice_admins).to match_array [@u_va4, @u_va1, @u_va3, @u_va2,]
    end

    it "can scope global_moderators" do
      expect(User.global_moderators).to match_array [@u_gm1, @u_gm2, @u_gm3]
    end

    it "is fucking test of test" do
      expect(@u_ge1.has_role?(:game_editor, :any)).to be true
    end

    it "can scope game_editors" do
      expect(User.game_editors).to match_array [@u_ge2, @u_ge1]
    end

    it "can scope ranking_editors" do
      expect(User.calculated_position_editors).to match_array [@u_re1, @u_re2]
    end

    it "can scope all_admins (not moderators, not editors)" do
      expect(User.all_admins).to match_array [@u_vsa, @u_sa, @u_va4, @u_va3, @u_va2, @u_va1,
      @u_a1, @u_a2, @u_a3]
    end

    it "can scope all_staff_members (admins + moderators and editors)" do
      expect(User.all_staff_members).to match_array [@u_vsa, @u_sa, @u_va4, @u_va3, @u_va2, @u_va1,
      @u_a1, @u_a2, @u_a3, @u_gm1, @u_gm2, @u_gm3, @u_ge2, @u_ge1, @u_re1, @u_re2]
    end

    it "can scope users" do
      expect(User.users).to match_array [@u1, @u2]
    end

    it "can scope new_users" do
      expect(User.new_users).to match_array [@u_n1, @u_n2]
    end

    it "can scope trusted_users" do
      expect(User.trusted_users).to match_array [@u_t1, @u_t2]
    end

    it "can scope blocked_users" do
      expect(User.blocked_users).to match_array [@u_bl2, @u_bl1]
    end

    it "can scope banned_users" do
      expect(User.banned_users).to match_array [@u_ba2, @u_ba1]
    end

    it "can scope evaporated_users" do
      expect(User.evaporated_users).to match_array [@u_e2, @u_e1]
    end

    it "can scope not_banned_users (not banned and not evaporated)" do
      expect(User.not_banned_users).to match_array [@u1, @u2, @u_bl2, @u_bl1, @u_t1, @u_t2, @u_n1, @u_n2]
    end


  end


end
