class SkillsController < ApplicationController

  before_filter :find_object, :except => [:index]

  # GET /skills
  # GET /skills.json
  def index
    @skills = Skill.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @skills }
    end
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @skill }
    end
  end

  # GET /skills/new
  # GET /skills/new.json
  def new
    @translation = skillTranslation.new

    render "new"
  end

  # GET /skills/1/edit
  def edit
  end

  # POST /skills
  # POST /skills.json
  def create
    @translation = SkillTranslation.new(params[:skill_translation])
    @skill.skill_translations.push @translation

    respond_to do |format|
      if @skill.save
        format.html { redirect_to @skill, notice: 'skill was successfully created.' }
        format.json { render json: @skill, status: :created, location: @skill }
      else
        format.html { render action: "new" }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /skills/1
  # PUT /skills/1.json
  def update
    respond_to do |format|
      if @translation.update_attributes(params[:skill_translation])
        format.html { redirect_to @skill, notice: 'Translation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skills/1
  # DELETE /skills/1.json
  def destroy
    @skill.destroy

    respond_to do |format|
      format.html { redirect_to skills_url }
      format.json { head :no_content }
    end
  end

  def destroy_translation
    @skill.skill_translations.delete(@translation)

    if @skill.skill_translations.size > 0
      @skill.save

      respond_to do |format|
        format.html { redirect_to skill_url(@skill) }
        format.json { head :no_content }
      end
    else
      @skill.destroy

      respond_to do |format|
        format.html { redirect_to skills_url }
        format.json { head :no_content }
      end
    end
  end

  private

  def find_object
    @skill = params.has_key?(:id) ? Skill.find(params[:id]) : Skill.new
    @translation = @skill.find_translation(params[:lang]) if params.has_key? :lang
  end

end
